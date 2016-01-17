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
    if cannot? :manage, User and (@user.role == 'admin' or @user.role == 'moderator')
      flash[:error] = 'Немає доступу'
      redirect_to @user
    else
      @user.update(role: 'banned')
      @user.requests.update_all(status: 'archived')
      redirect_to @user
    end
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
    @actual_requests = User.find(params[:id]).requests.where(status: 'actual').order(:created_at => :desc)
    respond_to do |format|
      format.js
    end
  end

  def archived_requests
    @archived_requests = User.find(params[:id]).requests.where(status: 'archived').order(:updated_at => :desc)
    respond_to do |format|
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
