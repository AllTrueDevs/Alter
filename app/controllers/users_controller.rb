class UsersController < ApplicationController
  load_and_authorize_resource except: [:select_requests, :search_settlements]
  before_action :set_user, except: [:index, :search, :search_settlements]
  before_action :authenticate_user!, except: [:select_requests, :search_settlements]

  def show
    redirect_to root_url, notice: 'Користувач ще не підтвердив реєстрацію' if @user.confirmed_at.nil?
    @requests = @user.requests.actual.order(created_at: :desc).page(params[:page]).per(10)
  end

  def index
    @users = User.where.not(confirmed_at: nil).order(:name).page(params[:page]).per(12)
  end

  def search
    @users = User.where.not(confirmed_at: nil).search(params[:search]).order(:name).page(params[:page]).per(12)
    respond_to :js
  end

  def search_settlements
    query, limit = autocomplete_params[:query], autocomplete_params[:limit].to_i
    json = nova_poshta_data(query, limit)
    begin
      @settlements = json.map do |data|
        {
           settlement: data[:Description],
           type: data[:SettlementTypeDescription],
           region: data[:AreaDescription],
           district: data[:RegionsDescription]
        }
      end
    rescue
      @settlements = []
    end
    respond_to do |format|
      format.json { render :json => @settlements }
    end
  end

  def change_ban_status
    if @user.role?(:banned)
      @user.update(role: 'author')
      @user.create_activity key: 'user.unban', status: 'new'
      redirect_to @user
    else
      @user.update(role: 'banned')
        @user.create_activity key: 'user.ban', status: 'new'
      @user.requests.update_all(status: 'declined')

      @user.requests.each do |request|
        request.decisions.destroy_all
      end

      decisions = Decision.where(helper: @user)
      decisions.destroy_all

      redirect_to @user
    end
  end

  def change_moder_status
    if @user.role?(:moderator)
      @user.update(role: 'author')
      @user.create_activity key: 'user.unmoder', status: 'new'
    else
      @user.update(role: 'moderator')
      @user.create_activity key: 'user.moder', status: 'new'
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
    @user.create_activity key: 'user.upvote', status: 'new', recipient: current_user unless @user == current_user
    respond_to :js
  end

  def downvote
    @user.downvote_from(current_user)
    @user.create_activity key: 'user.downvote', status: 'new', recipient: current_user unless @user == current_user
    respond_to :js
  end

  def activity
    @activities = PublicActivity::Activity.where(
        PublicActivity::Activity.arel_table[:owner_id].eq(@user.id)
        .and(PublicActivity::Activity.arel_table[:owner_type].eq('User'))
        .or(
            PublicActivity::Activity.arel_table[:trackable_id].eq(@user.id)
            .and(PublicActivity::Activity.arel_table[:trackable_type].eq('User'))
        )
    ).where.not(key: ['user.moder', 'user.unmoder', 'request.upvote', 'request.downvote', 'user.upvote',
                      'user.downvote']).order(created_at: :desc).page(params[:page]).per(10)
    respond_to :js
  end


  private


  def nova_poshta_data(query, limit)
    require 'json'
    require 'net/http'

    uri = URI('http://testapi.novaposhta.ua/v2.0/json/AddressGeneral/getSettlements/')
    uri.query = URI.encode_www_form({})
    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/json'
    request.body = {
        modelName: 'AddressGeneral',
        calledMethod: 'getSettlements',
        methodProperties: {
            # FindByString: query,
            MainCitiesOnly: true
            # MainCitiesOnly: query.blank?
        }
    }.to_json

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    # JSON.parse(response.body, symbolize_names: true)[:data]
    JSON.parse(response.body, symbolize_names: true)[:data]
        .select{ |data| data[:Description].downcase.include? query }.take(limit)
  end

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
