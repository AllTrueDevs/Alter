require 'i18n'
RailsAdmin.config do |config|
  config.main_app_name = ['Alter', 'панель адміністратора']
  # I18n.default_locale = :'en'

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  config.authorize_with :cancan, AdminAbility

  config.excluded_models = ['AcceptedItem', 'HelpedItem', 'RequiredItem']

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
        formatted_value do
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
          Hash[ ['Адміністратор', 'Модератор', 'Користувач', 'Заблокований'].zip(['admin', 'moderator', 'author', 'banned']) ]
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
            when 'actual' then 'Активний'
            when 'archived' then 'Заархівований'
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
            when 'actual' then 'Активний'
            when 'archived' then 'Заархівований'
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
          Hash[ ['Активний', 'Заархівований'].zip(['actual', 'archived']) ]
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
      field :color do
        formatted_value do
          case value
            when 1 then 'Салатовий'
            when 2 then 'Зелений'
            when 3 then 'Голубий'
            when 4 then 'Фіолетовий'
            when 5 then 'Жовтий'
            when 6 then 'Помаранчевий'
            when 7 then 'Червоний'
            when 8 then 'Синій'
          end
        end
      end
      field :updated_at
      field :created_at
    end

    show do
      field :name
      field :color do
        formatted_value do
          case value
            when 1 then 'Салатовий'
            when 2 then 'Зелений'
            when 3 then 'Голубий'
            when 4 then 'Фіолетовий'
            when 5 then 'Жовтий'
            when 6 then 'Помаранчевий'
            when 7 then 'Червоний'
            when 8 then 'Синій'
          end
        end
      end
    end
    #
    edit do
      field :name do
        required true
      end
      field :color, :enum do
        enum do
          Hash[ ['Салатовий', 'Зелений', 'Голубий', 'Фіолетовий', 'Жовтий', 'Помаранчевий', 'Червоний', 'Синій']
                .zip([1, 2, 3, 4, 5, 6, 7, 8]) ]
        end
      end
    end
  end

  config.model 'Notification' do
    list do
      field :id
      field :status do
        formatted_value do
          case value
            when 'new' then 'Нове'
            when 'read' then 'Прочитане'
          end
        end
      end
      field :user
      field :updated_at
      field :created_at
    end

    show do
      field :status do
        formatted_value do
          case value
            when 'new' then 'Нове'
            when 'read' then 'Прочитане'
          end
        end
      end
      field :user
      field :request do
        visible do
          !bindings[:object].request.nil?
        end
      end
      field :message do
        formatted_value do
          value.html_safe
        end
      end
    end
    #
    edit do
      field :status, :enum do
        enum do
          Hash[ ['Нове', 'Прочитане'].zip(['new', 'read']) ]
        end
      end
      field :user
      field :message_type
      field :reason_user
      field :request
    end
  end




end
