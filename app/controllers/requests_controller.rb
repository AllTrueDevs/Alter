class RequestsController < ApplicationController
  load_and_authorize_resource except: [:create, :show, :index]
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :create, :destroy, :new, :update, :unchecked_requests]
  before_filter :log_impression, only: [:show]

  def index
    @requests = if params[:category_id].nil?
                  Request.actual.order(created_at: :desc).page(params[:page]).per(10)
                else
                  Request.where(status: 'actual').joins(:required_items)
                      .where(required_items: {category_id: params[:category_id]})
                      .order(created_at: :desc).page(params[:page]).per(10)
                end
  end

  def unchecked_requests
    @requests = Request.unchecked.order(created_at: :desc).page(params[:page]).per(10)
    render template: 'requests/index'
  end

  def check
    @request.update(status: 'actual')
    @request.user.notifications.create(message_type: 10, request_id: @request.id)
    respond_to :js
  end

  def decline
    @request.update(status: 'declined')
    @request.user.notifications.create(message_type: 11, request_id: @request.id)
    redirect_to unchecked_requests_url
  end

  def show
    @required_items = @request.required_items
    @posts = @request.posts.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def new
    @request = Request.new
  end

  def edit
    redirect_to root_url, notice: 'Цей запит закрито.' if @request.status?(:archived)
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    respond_to do |format|
      if @request.valid? && !params[:categories].nil?
        @request.save
        @categories = params[:categories]
        @categories.each{ |category| @request.required_items.create(category_id: category.split('::')[0]) }
        format.html { redirect_to @request}
      else
        format.html { redirect_to :back, notice: 'Помилка введення даних' }
      end
    end
  end

  def update
    respond_to do |format|
      if @request.update(request_params)
        @request.update(status: 'unchecked')
        @request.decisions.each{ |decision| User.find(decision.helper_id).notifications.create(message_type: 8, reason_user_id: current_user.id, request_id: decision.request_id) }
        @request.decisions.destroy_all
        @request.required_items.destroy_all
        @categories = params[:categories]
        @categories.each{ |category| @request.required_items.create(category_id: category) }
        format.html { redirect_to @request, notice: 'Запит успішно оновлено' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @request.update(status: 'archived')
    @request.decisions do |decision|
      User.find(decision.helper_id).notifications.create(message_type: 9, reason_user_id: current_user.id, request_id: decision.request_id)
    end
    @request.decisions.destroy_all
    respond_to do |format|
      format.html{ redirect_to @request }
      format.js
    end
  end

  def upvote
    @request.upvote_from(current_user)
    respond_to :js
  end

  def downvote
    @request.downvote_from(current_user)
    respond_to :js
  end

  def log_impression
    @request.impressions.create(ip_address: request.remote_ip, user_id: current_user.nil? ? nil : current_user.id)
  end

  private


  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:name, :description, :user_id, :photo)
  end
end
