class PageController < ApplicationController
  def home
    @requests = Request.all.sort_by(&:unique_impression_count).reverse.take(5)
  end

  def about
  end
end
