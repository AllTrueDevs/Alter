class HomeController < ApplicationController
  def index
    @actual_request = Request.actual.last
  end
end

