class UsersController < ApplicationController
  load_and_authorize_resource except: [:select_requests]
  before_action :set_user, only: [:change_ban_status, :change_moder_status, :admin_login, :show, :detach_social_link, :select_requests]
  before_action :authenticate_user!, except: [:select_requests]

  def show
    if @user.confirmed_at.nil?
      redirect_to root_url, notice: 'Користувач ще не підтвердив реєстрацію'
    else
      @actual_requests = @user.requests.actual.order(:created_at => :desc).page(params[:page]).per(10)
      @helped_items = @user.helped_items.sort{ |item_1, item_2| [ item_2.count, item_1.category.name ] <=> [ item_1.count, item_2.category.name ] }
    end
  end

  def index
    @users = if params[:search].nil?
      User.where.not(confirmed_at: nil).order(:name).page(params[:page]).per(12)
    else
      User.where.not(confirmed_at: nil).search(params[:search]).order(:name).page(params[:page]).per(12)
    end
  end

  def change_ban_status
    if @user.role == 'banned'
      @user.update(role: 'author')
      @user.notifications.create(message_type: 5)
      redirect_to @user
    else
      if cannot? :manage, User and (@user.role == 'admin' or @user.role == 'moderator') #check if need and
        flash[:error] = 'Немає доступу'
        redirect_to @user
      else
        @user.update(role: 'banned')
        @user.notifications.create(message_type: 4)
        @user.requests.update_all(status: 'declined')

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

  def change_password
    @user = User.find(current_user.id)
    if @user.update_with_password(password_params) && !password_params[:password].blank?
      sign_in @user, :bypass => true
      flash[:notice] = 'Пароль успішно змінено'
    else
      @user.errors.add(:password, t('activerecord.errors.models.user.attributes.password.blank')) if password_params[:password].blank?
    end
    render 'devise/registrations/edit'
  end

  def detach_social_link
    @user.send("#{params[:social]}=", nil)
    @user.send("#{params[:social]}_name=", nil)
    @user.save
    redirect_to edit_user_registration_path
  end

  #TODO refactor next two methods

  def select_requests
    @requests = @user.requests.send(params[:requests_type]).order(params[:sort_field] => :desc)
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

  def password_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

end
