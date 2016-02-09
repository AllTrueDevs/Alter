class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def vkontakte
    current_user.vkontakte_oauth!(request.env['omniauth.auth'])
    redirect_to edit_user_registration_path
  end

  def facebook
    current_user.facebook_oauth!(request.env['omniauth.auth'])
    redirect_to edit_user_registration_path
  end

end
