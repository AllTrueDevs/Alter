class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :initializer

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

  def initializer
    if user_signed_in?
      @new_decisions = Decision.where(status: 'new', request: current_user.requests).size
      @new_notifications = current_user.notifications.where(status: 'new').size
    end
  end

end
