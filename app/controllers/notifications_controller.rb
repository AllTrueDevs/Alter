class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :destroy]

  def index
    new_notifications = Notification.where(status: 'new', user_id: current_user.id)
    old_notifications = Notification.where(status: 'read', user_id: current_user.id)
    @notifications = new_notifications + old_notifications
  end

  def show
    @notification.update(status: 'read')
    redirect_to notifications_path
  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def notification_params
      params.require(:category).permit(:body, :status, :user_id)
    end
end
