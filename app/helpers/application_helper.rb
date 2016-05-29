module ApplicationHelper
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

  def activity_message_type(activity)
    model, action = activity.key.split('.')
    if model == 'request'
      case(action)
      when 'archive' then "#{link_to('Запит', request_url(activity.trackable))} було заархівовано."
      when 'create' then "#{link_to('Запит', request_url(activity.trackable))} було створено."
      when 'update' then "#{link_to('Запит', request_url(activity.trackable))} було змінено."
      end
    elsif model == 'decision'
      case(action)
      when 'accept' then "Відгук за #{link_to('запитом', request_url(activity.recipient))} було прийнято."
      when 'create' then "Відгук за #{link_to('запитом', request_url(activity.recipient))} було створено."
      when 'deny' then "Відгук за #{link_to('запитом', request_url(activity.recipient))} було відхилено."
      when 'partly' then "Відгук за #{link_to('запитом', request_url(activity.recipient))} було частково прийнято."
      end
    end
  end
end
