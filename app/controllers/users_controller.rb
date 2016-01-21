class UsersController < ApplicationController
  before_action :set_user, only: [:ban, :unban, :moder, :unmoder, :show]
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource except: [:show, :actual_requests, :archived_requests]

  def show
    if @user.confirmed_at.nil?
      redirect_to root_path, notice: 'Користувач ще не підтвердив реєстрацію'
    else
      @actual_requests = User.find(params[:id]).requests.where(status: 'actual')
    end
  end

  def index
    if params[:search]
      @users = User.where.not(confirmed_at: nil).search(params[:search]).order("name DESC")
    else
      @users = User.where.not(confirmed_at: nil).order("name DESC")
    end
  end

  def ban
    if cannot? :manage, User and (@user.role == 'admin' or @user.role == 'moderator')
      flash[:error] = 'Немає доступу'
      redirect_to @user
    else
      @user.update(role: 'banned')
      Notification.create(message_type: 4, user_id: @user.id)
      @user.requests.update_all(status: 'archived')

      @user.requests.each do |request|
        request.decisions.each do |decision|
          decision.accepted_items.destroy_all
        end
        request.decisions.destroy_all
      end

      decisions = Decision.where(helper_id: @user.id)
      decisions.each do |decision|
        decision.accepted_items.destroy_all
      end
      decisions.destroy_all

      redirect_to @user
    end
  end

  def unban
    @user.update(role: 'author')
    Notification.create(message_type: 5, user_id: @user.id)
    redirect_to @user
  end

  def moder
    @user.update(role: 'moderator')
    Notification.create(message_type: 6, user_id: @user.id)
    redirect_to @user
  end

  def unmoder
    @user.update(role: 'author')
    Notification.create(message_type: 7, user_id: @user.id)
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
