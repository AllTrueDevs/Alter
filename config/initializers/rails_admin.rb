require 'i18n'
RailsAdmin.config do |config|
  config.main_app_name = ['Alter', 'панель адміністратора']
  # I18n.default_locale = :'en'

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  config.authorize_with :cancan, AdminAbility

  config.included_models = ['User', 'Request', 'Decision', 'Category']

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
      field :role
      field :email
      field :name
      field :requests_count, :integer do
        def value
          bindings[:object].requests.count
        end
      end
      field :decisions_count, :integer do
        def value
          bindings[:object].decisions.count
        end
      end
    end

    show do
      field :email
      field :name
      field :role do
        formatted_value do
          case value
            when 'admin' then 'Адміністратор'
            when 'moderator' then 'Модератор'
            when 'newsmaker' then 'Редактор'
            when 'author' then 'Користувач'
            when 'banned' then 'Заблокований'
          end
        end
      end
      field :info
      field :avatar
    end

    edit do
      field :email do
        required true
      end
      field :name do
        required true
      end
      field :role, :enum do
        enum do
          Hash[ ['Адміністратор', 'Модератор', 'Редактор', 'Користувач', 'Заблокований'].zip(['admin', 'moderator', 'newsmaker', 'author', 'banned']) ]
        end
      end
      field :reset_password_sent_at
      field :sign_in_count
      field :current_sign_in_at
      field :last_sign_in_at
      field :current_sign_in_ip
      field :last_sign_in_ip
      field :confirmation_token
      field :confirmed_at
      field :confirmation_sent_at
      field :info
      field :skype
      field :phone
      field :vkontakte
      field :facebook
      field :requests
      field :decisions
      field :avatar
    end
  end

  config.model 'Request' do
    list do
      field :id
      field :status do
        formatted_value do
          case value
            when 'unchecked' then 'Неперевірений'
            when 'actual' then 'Активний'
            when 'archived' then 'Заархівований'
            when 'declined' then 'Відхилений'
          end
        end
      end
      field :name
      field :user
      field :updated_at
      field :created_at
    end

    show do
      field :name do
        required true
      end
      field :status do
        formatted_value do
          case value
            when 'unchecked' then 'Неперевірений'
            when 'actual' then 'Активний'
            when 'archived' then 'Заархівований'
            when 'declined' then 'Відхилений'
          end
        end
      end
      field :description
      field :user
      field :photo
    end

    edit do
      field :name do
        required true
      end
      field :status, :enum do
        enum do
          Hash[ ['Неперевірений', 'Активний', 'Заархівований', 'Відхилений'].zip(['unchecked', 'actual', 'archived', 'declined']) ]
        end
      end
      field :description
      field :user
      field :decisions
      field :photo
    end
  end

  config.model 'Decision' do
    list do
      field :id
      field :status do
        formatted_value do
          case value
            when 'new' then 'Новий'
            when 'unaccepted' then 'Непідтверджений'
          end
        end
      end
      field :helper
      field :request
      field :updated_at
      field :created_at
    end

    show do
      field :helper
      field :status do
        formatted_value do
          case value
          when 'new' then 'Новий'
          when 'unaccepted' then 'Непідтверджений'
          end
        end
      end
      field :request
      field :description
    end
    #
    edit do
      field :helper do
        required true
      end
      field :request do
        required true
      end
      field :status, :enum do
        enum do
          Hash[ ['Новий', 'Непідтверджений'].zip(['new', 'unaccepted']) ]
        end
      end
      field :description
    end
  end

  config.model 'Category' do
    list do
      field :id
      field :name
      field :color, :color
      field :max
      field :updated_at
      field :created_at
    end

    show do
      field :name
      field :color, :color
      field :max
    end
    #
    edit do
      field :name do
        required true
      end
      field :color, :color
      field :max
    end
  end
end
