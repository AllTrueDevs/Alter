class RequestsController < ApplicationController
  include AmazonModule

  load_and_authorize_resource except: [:create, :show, :index, :refresh_counters, :search]
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :unchecked, :create, :update, :destroy, :upvote, :downvote, :log_impression]
  before_action :authenticate_user!, only: [:edit, :create, :destroy, :new, :update, :unchecked, :refresh_counters]
  before_filter :log_impression, only: [:show]

  def index
    @requests = Request.actual.order(created_at: :desc).page(params[:page]).per(10)
  end

  def search
    @requests = Request.actual.joins(:required_items)
                              .where(required_items: {category_id: params[:category_id]})
                              .order(created_at: :desc).page(params[:page]).per(10)
    respond_to :js
  end

  def unchecked
    @requests = Request.unchecked.near_with(@user).order(created_at: :desc).page(params[:page]).per(10)
    render template: 'requests/index'
  end

  def check
    @request.update(status: 'actual')
    @request.create_activity key: 'request.check', owner: @request.user
    @request.user.notifications.create(message_type: 10, request_id: @request.id)
    respond_to :js
  end

  def decline
    @request.update(status: 'declined')
    @request.create_activity key: 'request.decline', owner: @request.user
    @request.user.notifications.create(message_type: 11, request_id: @request.id)
    redirect_to unchecked_requests_url
  end

  def show
    @posts = @request.posts.order(updated_at: :desc).page(params[:page]).per(10)
    @activities = PublicActivity::Activity.where("(recipient_id=? and recipient_type='Request') or (trackable_id=? and trackable_type='Request')", @request.id, @request.id)
                      .order(created_at: :desc)
    if @request.status?(:actual) && can?(:create, Decision) && @request.user != @user
      @decision = Decision.new
      @decision.accepted_items.build
    end
  end

  def new
    @request = Request.new
    @request.required_items.build
  end

  def edit
  end

  def create
    @request = @user.requests.new(request_params)
    if @request.save
      @request.create_activity key: 'request.create', owner: @request.user
      redirect_to @request
    else
      errors = @request.form_errors(:request)
      flash[:error] = errors
      redirect_to :back
    end
  end

  def update
    clear_s3_object(@request.photo) unless @request.photo.size.nil? || request_params['photo'].nil?
    if @request.update(request_params.merge(status: 'unchecked'))
      @request.decisions do |decision|
        decision.helper.notifications.create(message_type: 8, reason_user: @user, request: decision.request)
      end
      @request.create_activity key: 'request.update', owner: @request.user
      @request.decisions.destroy_all
  
      redirect_to @request
    else
      errors = @request.form_errors(:request)
      flash[:error] = errors
      redirect_to :back
    end
  end

  def destroy
    @request.update(status: 'archived')
    @request.decisions do |decision|
      decision.helper.notifications.create(message_type: 9, reason_user: @user, request: decision.request)
    end
    @request.create_activity key: 'request.archive', owner: @request.user
    @request.decisions.destroy_all
    
    respond_to do |format|
      format.html{ redirect_to @request }
      format.js
    end
  end

  def upvote
    @request.user.notifications.create(message_type: 14, reason_user: @user, request: @request)
    @request.upvote_from(@user)
    respond_to :js
  end

  def downvote
    @request.user.notifications.create(message_type: 15, reason_user: @user, request: @request)
    @request.downvote_from(@user)
    respond_to :js
  end

  def log_impression
    @request.impressions.create(ip_address: request.remote_ip, user_id: @user.nil? ? nil : @user.id)
  end

  def refresh_counters
    @id = params['id'].to_i
    if params['type'] == 'required_items'
      @max = Category.find(@id).max
    else
      request = Request.find(params['request'].to_i)
      @max = request.required_items.find(@id).remaining_count
    end
    respond_to :js
  end

  def activity
    @activities = PublicActivity::Activity.where("(recipient_id=? and recipient_type='Request') or (trackable_id=? and trackable_type='Request')", @request.id, @request.id)
                                          .order(created_at: :desc)
    respond_to :js
  end

  def wall
    @posts = @request.posts.order(updated_at: :desc).page(params[:page]).per(10)
    respond_to :js
  end

  private


  def set_user
    @user = current_user
  end

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:name, :description, :user_id, :photo,
                                    required_items_attributes: [:id, :goal_count, :category_id, :_destroy])
  end
end
