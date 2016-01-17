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
      @new_decisions = Decision.where(status: 'new', request_id: Request.where(user_id: current_user.id)).size
      @new_notifications = current_user.notifications.where(status: 'new').size
    end
  end

end
