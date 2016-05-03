module DeviseHelper
    def devise_error_messages!
      return '' if resource.errors.empty?
      messages = resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join

      html = <<-HTML
        <div class="alert-error alert-block">
          #{messages}
        </div>
      HTML

      html.html_safe
    end
end