class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  def index
    @notifications = Notification.all
  end

  def show
  end

  def create
    @required_items = params[:required_items]
    @notification = Notification.new(helper_id: current_user.id, status: 'new', request_id: RequiredItem.find(@required_items[0]).request_id)

    respond_to do |format|
      if @notification.save
        @required_items.each do |x|
          AcceptedItem.create(notification_id: @notification.id, required_item_id: x)
        end
        format.html { redirect_to :back, notice: 'Notification was successfully created.' }
      else
        format.html { render :back }
      end
    end
  end

  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
    end
  end

  private
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def notification_params
      params.require(:notification).permit(:helper_id, :request_id, status)
    end
end
