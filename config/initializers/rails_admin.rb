require 'i18n'
RailsAdmin.config do |config|
  config.main_app_name = ['Alter', 'панель адміністратора']
  # I18n.default_locale = :'en'

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  config.authorize_with :cancan, AdminAbility

  config.included_models = ['User', 'Request']

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['User']
    end
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'User' do
      list do
      field :id
      field :role do
        formatted_value do # used in form views
          case value
          when 'admin' then 'Адміністратор'
          when 'moderator' then 'Модератор'
          when 'author' then 'Користувач'
          when 'banned' then 'Заблокований'
          end
        end
      end
      field :email
      field :name
      field :last_sign_in_ip
    end

    edit do
      field :email do
        required true
      end
      field :role, :enum do
        enum do
          Hash[ ['Адміністратор', 'Модератор', 'Користувач', 'Заблокований'].zip(['admin', 'moderator', 'author', 'banned']) ]
        end
      end
      field :name do
        required true
      end
      field :info
      field :phone
      field :skype
      field :vkontakte
      field :facebook
      field :avatar
    end
  end
end
