class DecisionsController < ApplicationController
  before_action :set_decision, only: [:show, :accept, :deny]
  load_and_authorize_resource except: [:create]

  def index
    @decisions = Decision.where(request_id: Request.where(user_id: current_user.id)).order(:status, :created_at => :desc)
  end

  def show
    @accepted_items = @decision.accepted_items
    if (Decision.find(params[:id]).status == 'new')
      Decision.find(params[:id]).update(:status => 'unaccepted')
      @new_notifications = @new_notifications-1
    end
  end

  def create
    @required_items = params[:required_items]
    @decision = Decision.new(description: params[:description], helper_id: current_user.id, request_id: params[:request_id])
    respond_to do |format|
      if @decision.valid? and @required_items != nil
        @decision.save
        @required_items.each do |x|
          AcceptedItem.create(decision_id: @decision.id, required_item_id: x)
        end
        format.html { redirect_to :back, notice: 'Вашу пропозицію допомоги відправлено' }
      else
        format.html { redirect_to :back, notice: 'Усі поля повині бути заповнені' }
      end
    end
  end

  def accept
    Notification.create(message_type: 1, reason_user_id: current_user.id, request_id: @decision.request_id, user_id: @decision.helper_id)
    @decision.accepted_items.each do |item|
      Decision.update_helped_items(item)
    end
    @decision.accepted_items.destroy_all
    @decision.destroy
    redirect_to decisions_path
  end

  def partly
    @accepted_items = params[:accepted_items]
    respond_to do |format|
      if @accepted_items != nil
        Notification.create(message_type: 2, reason_user_id: current_user.id, request_id: @decision.request_id, user_id: @decision.helper_id)
        @accepted_items.each do |id|
          item = AcceptedItem.find(id)
          Decision.update_helped_items(item)
        end
        @decision.accepted_items.destroy_all
        @decision.destroy
        format.html { redirect_to decisions_path }
      else
        format.html { redirect_to :back, notice: 'Оберіть категорії' }
      end
    end
  end

  def deny
    Notification.create(message_type: 3, reason_user_id: current_user.id, request_id: @decision.request_id, user_id: @decision.helper_id)
    @decision.accepted_items.destroy_all
    @decision.destroy
    redirect_to decisions_path
  end

  private
    def set_decision
      @decision = Decision.find(params[:id])
    end

    def decision_params
      params.require(:decision).permit(:helper_id, :request_id, status)
    end
end
