module ApplicationHelper
  def home_page?
    controller_name == 'page' && action_name == 'home'
  end
end
