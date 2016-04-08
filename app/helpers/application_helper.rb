module ApplicationHelper
  def default_page?
    controller_name != 'home'
  end
end
