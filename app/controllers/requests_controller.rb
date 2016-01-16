class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :create, :destroy, :new, :update]
  load_and_authorize_resource except: [:create]

  def index
    if params[:id].nil?
      @requests = Request.all
    else
      @requests = Request.where(:user_id => params[:id])
    end
  end

  def show
    @required_items = @request.required_items
  end

  def new
    @request = Request.new
  end

  def edit
    @collection = @request.required_items.collect(&:category_id)
  end

  def create

    @request = Request.new(request_params)
    @request.user = current_user

    respond_to do |format|
      if @request.save
        @categories = params[:categories]
        @categories.each do |x|
          RequiredItem.create(request_id: @request.id, category_id: x)
        end
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @request.update(request_params)
        Decision.where(request_id: @request.id).each do |decision|
          Notification.create(status: 'new', body: "#{current_user.name} змінив свій запит про допомогу #{@request.name}.", user_id: decision.helper_id)
        end
        Decision.where(request_id: @request.id).destroy_all
        RequiredItem.where(:request_id => @request.id).destroy_all
        @categories = params[:categories]
        @categories.each do |x|
          RequiredItem.create(request_id: @request.id, category_id: x)
        end
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
    end
  end

  private
    def set_request
      @request = Request.find(params[:id])
    end

    def request_params
      params.require(:request).permit(:name, :description, :user_id, :photo)
    end
end
