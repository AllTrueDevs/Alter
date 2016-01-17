class UsersController < ApplicationController
  before_action :set_user, only: [:ban, :unban, :moder, :unmoder]
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def ban
    @user.update(role: 'banned')
    redirect_to @user
  end

  def unban
    @user.update(role: 'author')
    redirect_to @user
  end

  def moder
    @user.update(role: 'moderator')
    redirect_to @user
  end

  def unmoder
    @user.update(role: 'author')
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
