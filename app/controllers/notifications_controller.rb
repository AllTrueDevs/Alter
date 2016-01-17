class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :destroy]

  def index
    new_notifications = current_user.notifications.where(status: 'new')
    old_notifications = current_user.notifications.where(status: 'read')
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

  def clean
    Notification.delete_all
    redirect_to notifications_path, notice: 'Всі сповіщення видалено'
  end

  private
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def notification_params
      params.require(:category).permit(:body, :status, :user_id)
    end
end
