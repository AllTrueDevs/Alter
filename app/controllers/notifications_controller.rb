class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :destroy]
  load_and_authorize_resource except: [:clean]

  def index
    @notifications = current_user.notifications.paginated(params[:page], 15)
  end

  def show
    @notification.update(status: 'read')
    @notifications = current_user.notifications.paginated(params[:page], 15)
    @new_notifications = @new_notifications - 1
    begin
      respond_to :js
    rescue
      redirect_to notifications_url
    end
  end

  def destroy
    @new_notifications = @new_notifications - 1 if @notification.status == 'new'
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Notification was successfully destroyed.' }
      format.js { render :layout => false }
    end
  end

  def clean
    current_user.notifications.destroy_all
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
