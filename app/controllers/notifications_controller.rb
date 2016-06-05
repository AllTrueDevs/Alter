class NotificationsController < ApplicationController
  authorize_resource class: false
  before_action :set_notification, only: [:show]
  before_action :set_notifications, only: [:show, :index]

  def index
  end

  def show
    @notification.update(status: 'read')
    respond_to :js
  end

  private
    def set_notification
      @notification = PublicActivity::Activity.find(params[:id])
    end

    def set_notifications
      @notifications = current_user.notifications.order(status: :asc, created_at: :desc).page(params[:page]).per(20)
    end
end
