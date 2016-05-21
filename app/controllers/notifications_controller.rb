class NotificationsController < ApplicationController
  load_and_authorize_resource except: [:clean]
  before_action :set_notification, only: [:show, :destroy]
  before_action :set_notifications, only: [:index, :show]

  def index
  end

  def show
    @notification.update(status: 'read')
    begin
      respond_to :js
    rescue
      redirect_to notifications_url
    end
  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Notification was successfully destroyed.' }
      format.js { render :layout => false }
    end
  end

  def clean
    current_user.notifications.destroy_all
    redirect_to notifications_url, notice: 'Всі сповіщення видалено'
  end

  private
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def set_notifications
      @notifications = current_user.notifications.paginated(params[:page], 15)
    end

    def notification_params
      params.require(:category).permit(:body, :status, :user_id)
    end
end
