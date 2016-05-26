module NotificationsHelper
  def form_user_link(user)
    "<a href=\"/id#{user.id}\">#{user.name}</a>"
  end


  def form_request_link(request)
    "href=\"/requests/#{request.id}\""
  end
end
