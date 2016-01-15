class HomeController < ApplicationController

  def index
    if user_signed_in?
      @notifications = Notification.where(request_id: Request.where(user_id: current_user.id))
    end
  end

end
