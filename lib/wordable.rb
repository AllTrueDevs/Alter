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

  def notification_activity_message_text(activity)
    case activity.key
      when 'decision.accept' then "#{form_user_link(activity.owner)} підтвердив те, що ви допомогли по запиту #{form_request_link(activity.recipient)}."
      when 'decision.deny' then "#{form_user_link(activity.owner)} відхилив факт допомоги по запиту #{form_request_link(activity.recipient)}."
      when 'decision.partly' then "#{form_user_link(activity.owner)} підтвердив те, що ви частково допомогли по запиту #{form_request_link(activity.recipient)}."
      when 'decision.archive_request' then "#{form_user_link(activity.owner)} заархівував запит #{form_request_link(activity.recipient)}."
      when 'decision.update_request' then "#{form_user_link(activity.owner)} оновив запит #{form_request_link(activity.recipient)}."
      when 'request.check' then "Запит #{form_request_link(activity.trackable)} було перевірено адміністрацією."
      when 'request.decline' then "Запит #{form_request_link(activity.trackable)} було відхилено адміністрацією."
      when 'user.ban' then 'Ваш аккаунт було заблоковано адміністрацією.'
      when 'user.unban' then 'Ваш аккаунт було розблоковано адміністрацією.'
      when 'user.moder' then 'Вашому аккаунту було надано права модератора.'
      when 'user.unmoder' then 'Вашому аккаунту було надано права звичайного користувача.'
      when 'user.upvote' then "#{form_user_link(activity.recipient)} поставив вам позитивний голос."
      when 'user.downvote' then "#{form_user_link(activity.recipient)} поставив вам негативний голос."
      when 'request.upvote' then "#{form_user_link(activity.recipient)} поставив позитивний голос на вашому запиті #{form_request_link(activity.trackable)}."
      when 'request.downvote' then "#{form_user_link(activity.recipient)} поставив негативний голос на вашому запиті #{form_request_link(activity.trackable)}."
    end
  end

  def user_activity_message_text(activity)
    case activity.key
      when 'decision.accept' then "Прийняв відгук за запитом #{form_request_link(activity.recipient)}."
      when 'decision.create' then "Створив відгук за запитом #{form_request_link(activity.recipient)}."
      when 'decision.deny' then "Відхилив відгук за запитом #{form_request_link(activity.recipient)}."
      when 'decision.partly' then "Частково прийняв відгук за запитом #{form_request_link(activity.recipient)}."
      when 'request.archive' then "Заархівував запит #{form_request_link(activity.trackable)}."
      when 'request.create' then "Створив запит #{form_request_link(activity.trackable)}."
      when 'request.update' then "Змінив запит #{form_request_link(activity.trackable)}."
      when 'request.check' then "Запит #{form_request_link(activity.trackable)} було перевірено адміністрацією."
      when 'request.decline' then "Запит #{form_request_link(activity.trackable)} було відхилено адміністрацією."
      when 'user.ban' then 'Аккаунт було заблоковано адміністрацією.'
      when 'user.unban' then 'Аккаунт було розблоковано адміністрацією.'
      when 'user.moder' then 'Аккаунту було надано права адміністратора.'
      when 'user.unmoder' then 'Аккаунт було надано права звичайного користувача.'
      when 'user.upvote' then "Поставив позитивний голос на запиті #{form_request_link(activity.trackable)}."
      when 'user.downvote' then "Поставив негативний голос на запиті #{form_request_link(activity.trackable)}."
      when 'request.upvote' then "Поставив позитивний голос на запиті #{form_request_link(activity.trackable)}."
      when 'request.downvote' then "Поставив негативний голос на запиті #{form_request_link(activity.trackable)}."
    end
  end

  def request_activity_message_text(activity)
    case activity.key
      when 'decision.accept' then "#{form_user_link(activity.owner)} прийняв допомогу від #{form_user_link(User.find(activity.parameters.fetch(:helper_id)))}."
      when 'decision.create' then "#{form_user_link(activity.owner)} створив відгук."
      when 'decision.deny' then "#{form_user_link(activity.owner)} відхилив допомогу від #{form_user_link(User.find(activity.parameters.fetch(:helper_id)))}."
      when 'decision.partly' then "#{form_user_link(activity.owner)} частково прийняв допомогу від #{form_user_link(User.find(activity.parameters.fetch(:helper_id)))}."
      when 'request.archive' then "#{form_user_link(activity.trackable.user)} заархівував запит."
      when 'request.create' then "#{form_user_link(activity.trackable.user)} створив запит."
      when 'request.update' then "#{form_user_link(activity.trackable.user)} змінив запит."
      when 'request.check' then 'Запит було перевірено адміністрацією.'
      when 'request.decline' then 'Запит було відхилено адміністрацією.'
      when 'request.upvote' then "#{form_user_link(activity.recipient)} поставив позитивний голос запиті."
      when 'request.downvote' then "#{form_user_link(activity.recipient)} поставив негативний голос запиті."
    end
  end

  def activity_icon(activity)
    action = activity.key.split('.')[1]
    case action
      when 'create' then 'fa fa-plus'
      when 'update', 'update_request' then 'fa fa-pencil'
      when 'archive', 'archive_request' then 'fa fa-archive'
      when 'check' then 'fa fa-check'
      when 'decline' then 'fa fa-ban'
      when 'accept' then 'fa fa-star'
      when 'deny' then 'fa fa-star-o'
      when 'partly' then 'fa fa-star-half-o'
      when 'ban' then 'fa fa-lock'
      when 'unban' then 'fa fa-unlock'
      when 'moder' then 'fa fa-user-secret'
      when 'unmoder' then 'fa fa-user'
      when 'upvote' then 'glyphicon glyphicon-thumbs-up'
      when 'downvote' then 'glyphicon glyphicon-thumbs-down'
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