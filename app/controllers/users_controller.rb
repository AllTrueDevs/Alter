class UsersController < ApplicationController
  before_action :set_user, only: [:ban, :unban, :moder, :unmoder]
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  def show
    @user = User.find(params[:id])
    @actual_requests = User.find(params[:id]).requests.where(status: 'actual')
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

  def actual_requests
    @actual_requests = User.find(params[:id]).requests.where(status: 'actual')
    respond_to do |format|
      format.js
    end
  end

  def archived_requests
    @archived_requests = User.find(params[:id]).requests.where(status: 'archived')
    respond_to do |format|
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
