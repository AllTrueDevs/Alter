class HomeController < ApplicationController
  def index
    @actual_request = Request.actual.last
    @top_users = User.all.sort_by {|post| post.helped_items_count }.reverse.take(3)
    @requests = Request.actual.limit(5).order(created_at: :desc)
  end
end

