class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :initializer

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  def initializer
    if user_signed_in?
      @new_decisions_count = Decision.where(status: 'new', request: current_user.requests).size
      @new_notifications_count = current_user.notifications.where(status: 'new').size
      @new_messages_count = current_user.received_messages.where(status: 'new').size
    end
  end

end
