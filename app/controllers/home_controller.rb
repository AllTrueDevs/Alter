class HomeController < ApplicationController

  def index
    if user_signed_in?
      new_notifications = Notification.where(status: 'new', request_id: Request.where(user_id: current_user.id)).size
      @notification_row = (new_notifications.zero?)? 'Сповіщення' : "Сповіщення(#{new_notifications})"
    end
  end

end
