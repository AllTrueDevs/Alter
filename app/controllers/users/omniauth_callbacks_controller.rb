class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  [:vkontakte, :facebook, :twitter].each do |type|
    define_method(type){ request_social(type) }
  end


  private


  def request_social(type)
    if request.env['omniauth.params']['login'].present?
      user = User.find_for_social_oauth(type, request.env['omniauth.auth'])
      login(user)
    else
      current_user.social_oauth!(type, request.env['omniauth.auth'])
      redirect_to edit_user_registration_url
    end
  end

  def login(user)
    if user.persisted?
      sign_in user
      redirect_to root_url
    else
      redirect_to new_user_session_path
    end
  end
end
