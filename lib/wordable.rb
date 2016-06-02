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

  def user_activity_message_text(activity)
    model, action = activity.key.split('.')
    case model
    when 'request'
      case action
      when 'archive' then "Заархівував запит #{form_request_link(activity.trackable)}."
      when 'create' then "Створив запит #{form_request_link(activity.trackable)}."
      when 'update' then "Змінив запит #{form_request_link(activity.trackable)}."
      when 'check' then "Запит #{form_request_link(activity.trackable)} було перевірено адміністрацією."
      when 'decline' then "Запит #{form_request_link(activity.trackable)} було відхилено адміністрацією."
      end
    when 'decision'
      case action
      when 'accept' then "Прийняв відгук за запитом #{form_request_link(activity.recipient)}."
      when 'create' then "Створив відгук за запитом #{form_request_link(activity.recipient)}."
      when 'deny' then "Відхилив відгук за запитом #{form_request_link(activity.recipient)}."
      when 'partly' then "Чістково прийняв відгук за запитом #{form_request_link(activity.recipient)}."
      end
    when 'user'
      case action
      when 'ban' then 'Аккаунт було заблоковано адміністрацією.'
      when 'unban' then 'Аккаунт було розблоковано адміністрацією.'
      end
    end
  end

  def request_activity_message_text(activity)
    model, action = activity.key.split('.')
    case model
      when 'request'
        case action
          when 'archive' then "#{form_user_link(activity.trackable.user)} заархівував запит."
          when 'create' then "#{form_user_link(activity.trackable.user)} створив запит."
          when 'update' then "#{form_user_link(activity.trackable.user)} змінив запит."
          when 'check' then 'Запит було перевірено адміністрацією.'
          when 'decline' then 'Запит було відхилено адміністрацією.'
        end
      when 'decision'
        case action
          when 'accept' then "#{form_user_link(activity.owner)} прийняв допомогу від #{form_user_link(User.find(activity.parameters.fetch(:helper_id)))}."
          when 'create' then "#{form_user_link(activity.owner)} створив відгук."
          when 'deny' then "#{form_user_link(activity.owner)} відхилив допомогу від #{form_user_link(User.find(activity.parameters.fetch(:helper_id)))}."
          when 'partly' then "#{form_user_link(activity.owner)} частково допомогу відук від #{form_user_link(User.find(activity.parameters.fetch(:helper_id)))}."
        end
    end
  end

  def activity_icon(activity)
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

  def user_role(user)
    case user.role
    when 'admin' then 'Адміністратор'
    when 'moderator' then 'Модератор'
    when 'newsmaker' then 'Редактор'
    when 'banned' then 'Заблокований'
    else ''
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