class DecisionsController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :set_decision, only: [:show, :accept, :deny]

  def index
    @decisions = Decision.where(request: current_user.requests)
                     .order(:status, created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @accepted_items = @decision.accepted_items
    @decision.update(status: 'unaccepted') if @decision.status?(:new)
  end

  def create
    @decision = Decision.new(decision_params)
    if @decision.save
      @decision.create_activity recipient: @decision.request, status: 'new', parameters: { helper_id: @decision.request.user.id }, key: 'decision.create', owner: current_user
      flash[:success] = 'Вашу пропозицію допомоги відправлено'
    else
      flash[:error] = @decision.form_errors(:decision)
    end
    redirect_to :back
  end

  def accept
    @decision.create_activity recipient: @decision.request, status: 'new', parameters: { helper_id: @decision.helper_id }, key: 'decision.accept', owner: current_user

    @decision.accepted_items.each do |item|
      @decision.helper.update_helped_item!(item.required_item.category, item.count)
      @decision.request.update_goal!(item.required_item, item.count)
    end
    @decision.destroy
    redirect_to decisions_url
  end

  def partly
    data = Hash[decision_params['accepted_items_attributes'].map{ |key, value| [value['id'].to_i, value['count'].to_i] }]
    ids = data.map{ |key, value| key }
    accepted_items = @decision.accepted_items.where(id: ids)
    respond_to do |format|
      @decision.create_activity recipient: @decision.request, status: 'new', parameters: { helper_id: @decision.helper_id }, key: 'decision.partly', owner: current_user

      accepted_items.each do |item|
        @decision.helper.update_helped_item!(item.required_item.category, data[item.id])
        @decision.request.update_goal!(item.required_item, data[item.id])
      end

      @decision.destroy
      format.html { redirect_to decisions_url }
    end
  end

  def deny
    @decision.create_activity recipient: @decision.request, status: 'new', parameters: { helper_id: @decision.helper_id }, key: 'decision.deny', owner: current_user
    @decision.destroy
    redirect_to decisions_url
  end

  private
    def set_decision
      @decision = Decision.find(params[:id])
    end

    def decision_params
      params.require(:decision).permit(:description, :helper_id, :request_id,
                                       accepted_items_attributes: [:id, :count, :required_item_id, :_destroy])
    end
end
