module Wordable
  def human_truncate(name, max, ending = '...', splitter = ' ')
    return name if name.size <= max
    add = symbols.include?(name[max])? true : false
    part = name.truncate(max).gsub(/[#{regular_symbols}]+$/, '').split(splitter)
    part = (part.size > 1)? part[0..-2].join(splitter) : part.join
    if add
      part = part.gsub(/[#{regular_symbols}]+$/, '')
      "#{part}#{ending}"
    else
      part = part.split
      (part.size > 1)? part[0..-2].join(' ') : part.join
    end
  end

  def form_user_link(user)
    "<a href=\"/id#{user.id}\">#{user.name}</a>"
  end

  def form_request_link(request)
    "\"<a href=\"/requests/#{request.id}\" title=\"#{request.name}\">#{human_truncate(request.name, 35)}</a>\""
  end

  def activity_message_type(activity)
    model, action = activity.key.split('.')
    case model
    when 'request'
      case action
      when 'archive' then "Запит #{form_request_link(activity.trackable)} було заархівовано."
      when 'create' then "Запит #{form_request_link(activity.trackable)} було створено."
      when 'update' then "Запит #{form_request_link(activity.trackable)} було змінено."
      when 'check' then "Запит #{form_request_link(activity.trackable)} було перевірено адміністрацією."
      when 'decline' then "Запит #{form_request_link(activity.trackable)} було відхилено адміністрацією."
      end
    when 'decision'
      case action
      when 'accept' then "Відгук за запитом #{form_request_link(activity.recipient)} було прийнято."
      when 'create' then "Відгук за запитом #{form_request_link(activity.recipient)} було створено."
      when 'deny' then "Відгук за запитом #{form_request_link(activity.recipient)} було відхилено."
      when 'partly' then "Відгук за запитом #{form_request_link(activity.recipient)} було частково прийнято."
      end
    when 'user'
      case action
      when 'ban' then 'Аккаунт було заблоковано адміністрацією.'
      when 'unban' then 'Аккаунт було розблоковано адміністрацією.'
      end
    end
  end

  def activity_icon_type(activity)
    model, action = activity.key.split('.')
    case action
      when 'create' then 'fa fa-plus'
      when 'update' then 'fa fa-pencil'
      when 'archive' then 'fa fa-archive'
      when 'check' then 'fa fa-check'
      when 'decline' then 'fa fa-ban'
      when 'accept' then 'fa fa-star'
      when 'deny' then 'fa fa-star-o'
      when 'partly' then 'fa fa-star-half-o'
      when 'ban' then 'fa fa-lock'
      when 'unban' then 'fa fa-unlock'
    end
  end

  private


  def regular_symbols
    '\[,-.\/\s()\\+*<>\]=:;'
  end

  def symbols
    [ '[', ' ', '[', '-', ',', '.', '\\', '/', '+', '-', '*', '<', '>', ']', '=', ':', ';' ]
  end
end