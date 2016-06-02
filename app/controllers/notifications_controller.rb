class NotificationsController < ApplicationController
  authorize_resource class: false
  before_action :set_notification, only: [:show, :destroy]

  def index
    @notifications = current_user.notificationss.order(created_at: :desc)
  end

  def show
    @notification.update(status: 'read')
    respond_to :js
  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to requests_url }
      format.js { render layout: false }
    end
  end

  def clean
    current_user.notifications.destroy_all
    redirect_to notifications_url
  end

  private
    def set_notification
      # @notification = Notification.find(params[:id])
    end

    def notification_params
      params.require(:category).permit(:body, :status, :user_id)
    end
end
