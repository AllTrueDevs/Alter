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
    if model == 'request'
      case(action)
        when 'archive' then "#{link_to('Запит', request_url(activity.trackable))} було заархівовано."
        when 'create' then "#{link_to('Запит', request_url(activity.trackable))} було створено."
        when 'update' then "#{link_to('Запит', request_url(activity.trackable))} було змінено."
        when 'check' then "#{link_to('Запит', request_url(activity.trackable))} було перевірено адміністрацією."
        when 'decline' then "#{link_to('Запит', request_url(activity.trackable))} було відхилено адміністрацією."
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

  private


  def regular_symbols
    '\[,-.\/\s()\\+*<>\]=:;'
  end

  def symbols
    [ '[', ' ', '[', '-', ',', '.', '\\', '/', '+', '-', '*', '<', '>', ']', '=', ':', ';' ]
  end
end