module NotificationsHelper
  def form_user_link(user)
    "<a href=\"/id#{user.id}\">#{user.name}</a>"
  end


  def form_request_link(request)
    "<a href=\"/requests/#{request.id}\">\"#{request.name}\"</a>"
  end
end
