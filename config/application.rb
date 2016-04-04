require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Alter
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    ActionMailer::Base.smtp_settings = {
        :address        => 'smtp.gmail.com',
        :domain         => 'mail.google.com',
        :port           => 587,
        :user_name      => ENV['GMAIL_USERNAME'],
        :password       => ENV['GMAIL_PASSWORD'],
        :authentication => 'login',
        :enable_starttls_auto => true
    }
  end
end
