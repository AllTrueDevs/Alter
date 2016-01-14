class HomeController < ApplicationController

  def index
    @requests = Request.where(user_id: current_user.id)
    @notifications = Notification.where(request_id: @requests)
  end

end
