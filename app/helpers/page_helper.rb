module PageHelper
  def circle_link(request)
    !request.nil? ? request_url(request) : '#'
  end
end
