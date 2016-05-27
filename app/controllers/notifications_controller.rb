class NotificationsController < ApplicationController
  load_and_authorize_resource except: [:clean]
  before_action :set_notification, only: [:show, :destroy]
  before_action :set_notifications, only: [:index, :show]

  def index
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
      @notification = Notification.find(params[:id])
    end

    def set_notifications
      @notifications = current_user.notifications.order('status ASC, created_at DESC').paginated(params[:page], 15)
    end

    def notification_params
      params.require(:category).permit(:body, :status, :user_id)
    end
end
