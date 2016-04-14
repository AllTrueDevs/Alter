module ApplicationHelper
  def default_page?
    controller_name != 'page' && action_name != 'home'
  end

  def home_page?
    puts "keeeek: #{controller_name} leeeeel: #{action_name} #{controller_name == 'page' && action_name == 'home'}"
    controller_name == 'page' && action_name == 'home'
  end
end
