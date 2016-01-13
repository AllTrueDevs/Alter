class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def ban(user)
    if (user.role == 'author')
      user.role = 'banned'
    else
      user.role = 'author'
    end
    redirect_to :back
  end

end
