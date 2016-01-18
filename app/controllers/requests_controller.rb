class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :create, :destroy, :new, :update]
  load_and_authorize_resource except: [:create, :show, :index]

  def index
    @requests = Request.where(status: 'actual')
  end

  def show
    @required_items = @request.required_items
  end

  def new
    @request = Request.new
  end

  def edit
    redirect_to root_url if @request.status == 'archived'
    @collection = @request.required_items.collect(&:category_id)
  end

  def create

    @request = Request.new(request_params)
    @request.user = current_user

    respond_to do |format|
      if @request.save
        @categories = params[:categories]
        @categories.each{ |category| RequiredItem.create(request_id: @request.id, category_id: category) }
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @request.update(request_params)
        @request.decisions.each do |decision|
          Notification.create(body: "#{current_user.name} змінив запит про допомогу \"#{@request.name}\".", user_id: decision.helper_id)
        end
        @request.decisions.destroy_all
        @request.required_items.destroy_all
        @categories = params[:categories]
        @categories.each{ |category| RequiredItem.create(request_id: @request.id, category_id: category) }
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @request.update(status: 'archived')
    @request.decisions.each do |decision|
      Notification.create(body: "#{current_user.name} закрив запит про допомогу \"#{@request.name}\".", user_id: decision.helper_id)
    end
    @request.decisions.destroy_all

    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Запит на допомогу закрито' }
      format.js { render :layout => false }
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
