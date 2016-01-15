class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def dashboard
    new_decisions = Decision.where(status: 'new', request_id: Request.where(user_id: current_user.id)).size
    @decision_row = (new_decisions.zero?)? 'Відгуки про допомогу' : "Відгуки про допомогу(#{new_decisions})"
    new_notifications = Notification.where(status: 'new', user_id: current_user.id).size
    @notification_row = (new_notifications.zero?)? 'Сповіщення' : "Сповіщення(#{new_notifications})"

  end

end
