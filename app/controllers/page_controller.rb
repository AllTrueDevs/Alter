class PageController < ApplicationController
  def home
    @requests = Array.new(5)
    Request.limit(5).all.order(created_at: :desc).each do |request|
      @requests << request
    end
  end

  def about
  end
end
