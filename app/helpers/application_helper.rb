module ApplicationHelper
  include Wordable
  def home_page?
    controller_name == 'page' && action_name == 'home'
  end

  def flash_class(level)
    case level.to_sym
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-danger'
    when :alert then 'alert alert-warning'
    end
  end
end
