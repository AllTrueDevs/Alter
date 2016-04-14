class UsersController < ApplicationController
  before_action :set_user, only: [:change_ban_status, :change_moder_status, :admin_login, :show, :actual_requests, :archived_requests]
  before_action :authenticate_user!, except: [:actual_requests, :archived_requests]
  load_and_authorize_resource except: [:actual_requests, :archived_requests]

  def show
    if @user.confirmed_at.nil?
      redirect_to root_url, notice: 'Користувач ще не підтвердив реєстрацію'
    else
      @actual_requests = @user.requests.actual.order(:created_at => :desc).page(params[:page]).per(10)
      @helped_items = @user.helped_items.sort{ |item_1, item_2| [ item_2.count, item_1.category.name ] <=> [ item_1.count, item_2.category.name ] }
    end
  end

  def index
    @users = params[:search] ? User.where.not(confirmed_at: nil).search(params[:search]).order(:name).page(params[:page]).per(12) : User.where.not(confirmed_at: nil).order(:name).page(params[:page]).per(12)
  end

  def change_ban_status
    if @user.role == 'banned'
      @user.update(role: 'author')
      @user.notifications.create(message_type: 5)
      redirect_to @user
    else
      if cannot? :manage, User and (@user.role == 'admin' or @user.role == 'moderator')
        flash[:error] = 'Немає доступу'
        redirect_to @user
      else
        @user.update(role: 'banned')
        @user.notifications.create(message_type: 4)
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
  end

  def change_moder_status
    if @user.role == 'moderator'
      @user.update(role: 'author')
      @user.notifications.create(message_type: 7)
    else
      @user.update(role: 'moderator')
      @user.notifications.create(message_type: 6)
    end
    redirect_to @user
  end

  def admin_login
    sign_in(@user)
    redirect_to root_url
  end

  def actual_requests
    @actual_requests = @user.requests.actual.order(:created_at => :desc).page(params[:page]).per(10)
    respond_to :js
  end

  def archived_requests
    @archived_requests = @user.requests.archived.order(:updated_at => :desc).page(params[:page]).per(10)
    respond_to :js
  end

  def statistic
    @items = @user.helped_items
    unless @items.size.zero?
      max_vals = [4, 12, 20, 30, 40, 60, 100, 150, 200, 250, 500, 1000]
      maximum_items = max_vals.detect{|value| value >= @items.pluck(:count).max }
      @max = maximum_items ? maximum_items : @items.pluck(:count).max
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
