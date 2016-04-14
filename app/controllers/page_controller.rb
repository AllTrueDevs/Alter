class PageController < ApplicationController
  def home
    @actual_request = Request.actual.last
    @top_users = User.all.sort_by {|post| post.helped_items_count }.reverse.take(3)
    @requests = []
    loop do
      request = Request.actual.offset(Random.rand(Request.actual.size)).first
      @requests << request unless @requests.include? request
      break if @requests.size == 5
    end
  end

  def about
  end
end