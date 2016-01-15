class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :initializer

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def initializer
    if user_signed_in?
      new_decisions = Decision.where(status: 'new', request_id: Request.where(user_id: current_user.id)).size
      @decisions_row = (new_decisions.zero?)? 'Відгуки' : "Відгуки про допомогу(#{new_decisions})"
      new_notifications = Notification.where(status: 'new', user_id: current_user.id).size
      @notifications_row = (new_notifications.zero?)? 'Сповіщення' : "Сповіщення(#{new_notifications})"
    end
  end

end
