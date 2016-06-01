class UsersController < ApplicationController
  load_and_authorize_resource except: [:select_requests, :search_cities]
  before_action :set_user, only: [:change_ban_status, :change_moder_status, :admin_login, :show, :detach_social_link, :select_requests]
  before_action :authenticate_user!, except: [:select_requests, :search_cities]

  def show
    if @user.confirmed_at.nil?
      redirect_to root_url, notice: 'Користувач ще не підтвердив реєстрацію'
    else
      @requests = @user.requests.actual.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def index
    @users = User.where.not(confirmed_at: nil).order(:name).page(params[:page]).per(12)
  end

  def search
    @users = User.where.not(confirmed_at: nil).search(params[:search]).order(:name).page(params[:page]).per(12)
    respond_to :js
  end

  def search_cities
    require 'json'
    require 'net/http'

    query, limit = autocomplete_params[:query], autocomplete_params[:limit].to_i

    uri = URI('http://testapi.novaposhta.ua/v2.0/json/AddressGeneral/getSettlements/')
    uri.query = URI.encode_www_form({})
    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/json'
    request.body = {
        modelName: 'AddressGeneral',
        "calledMethod": 'getSettlements',
        methodProperties: {
            FindByString: query,
            MainCitiesOnly: query.blank?
        }
    }.to_json

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    json = json.nil? ? [] : json.take(limit).map{ |data| { type: data[:SettlementTypeDescription], city: data[:Description], region: data[:AreaDescription], district: data[:RegionsDescription] } }
    @cities = json
    respond_to do |format|
      format.json { render :json => @cities }
    end
  end

  def change_ban_status
    if @user.role?(:banned)
      @user.update(role: 'author')
      @user.notifications.create(message_type: 5)
      redirect_to @user
    else
      if cannot?(:manage, User) && @user.with_privileges?
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
    if @user.role?(:moderator)
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
      sign_in @user, bypass: true
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

  def select_requests
    @requests = @user.requests.send(params[:requests_type]).order(params[:sort_field] => :desc).page(params[:page]).per(10)
    respond_to :js
  end

  def statistic
    @items = @user.helped_items
    money = @items.where(category_id: 1)
    @items = { money: money, other: @items.where.not(category_id: 1) }
    @max = Hash.new
    unless @items[:other].empty?
      max_vals = [4, 12, 20, 30, 40, 60, 100, 150, 200, 250, 500, 1000, 2500, 5000]
      maximum_item = max_vals.detect{|value| value >= @items[:other].pluck(:count).max }
      @max[:other] = maximum_item.present? ? maximum_item : @items[:other].pluck(:count).max
    end
    unless @items[:money].empty?
      max_vals = [200, 250, 500, 1000, 2500, 5000, 10000, 25000, 50000, 100000, 250000, 500000, 1000000]
      maximum_item = max_vals.detect{|value| value >= @items[:money].first.count }
      @max[:money] = maximum_item.present? ? maximum_item : @items[:money].first.count
    end
    respond_to do |format|
      format.js
    end
  end

  def upvote
    @user.upvote_from(current_user)
    @user.notifications.create(message_type: 12, reason_user: current_user)
    respond_to :js
  end

  def downvote
    @user.downvote_from(current_user)
    @user.notifications.create(message_type: 13, reason_user: current_user)
    respond_to :js
  end

  def activity
    @activities = current_user.activity
    respond_to :js
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def autocomplete_params
    params.permit(:limit, :query)
  end
end
