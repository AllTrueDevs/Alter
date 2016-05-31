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


  private


  def regular_symbols
    '\[,-.\/\s()\\+*<>\]=:;'
  end

  def symbols
    [ '[', ' ', '[', '-', ',', '.', '\\', '/', '+', '-', '*', '<', '>', ']', '=', ':', ';' ]
  end
end