class HomeController < ApplicationController

  def index
    if user_signed_in?
      new_decisions = Decision.where(status: 'new', request_id: Request.where(user_id: current_user.id)).size
      @decision_row = (new_decisions.zero?)? 'Сповіщення' : "Сповіщення(#{new_decisions})"
    end
  end

end
