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
    @decision_row = (new_decisions.zero?)? 'Сповіщення' : "Сповіщення(#{new_decisions})"
  end

end
