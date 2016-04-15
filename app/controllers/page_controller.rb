class PageController < ApplicationController
  def home
    @requests = Array.new
    Request.all.limit(5).order(created_at: :desc).each{ |request| @requests << request }
  end

  def about
  end
end
