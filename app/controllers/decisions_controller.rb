class DecisionsController < ApplicationController
  before_action :set_decision, only: [:show, :accept, :deny]

  def index
    new_decisions = Decision.where(status: 'new', request_id: Request.where(user_id: current_user.id))
    unaccepted_decisions = Decision.where(status: 'unaccepted', request_id: Request.where(user_id: current_user.id))
    @decisions = new_decisions + unaccepted_decisions
  end

  def show
    Decision.find(params[:id]).update(:status => 'unaccepted')
  end

  def create
    @required_items = params[:required_items]
    @decision = Decision.new(helper_id: current_user.id, request_id: RequiredItem.find(@required_items[0]).request_id)

    respond_to do |format|
      if @decision.save
        @required_items.each do |x|
          AcceptedItem.create(decision_id: @decision.id, required_item_id: x)
        end
        format.html { redirect_to :back, notice: 'Decision was successfully created.' }
      else
        format.html { render :back }
      end
    end
  end

  def accept
    Notification.create(body: current_user.name + ' підтвердив те, що ви дійсно допомогли.', user_id: @decision.helper_id)
    @decision.destroy
    redirect_to decisions_path
  end

  def deny
    Notification.create(body: current_user.name + ' відхилив факт вашої допомоги.', user_id: @decision.helper_id)
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
