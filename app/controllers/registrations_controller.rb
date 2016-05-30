class RegistrationsController < Devise::RegistrationsController
  include AmazonModule

  def update
      clear_s3_object(@user.avatar) unless @user.avatar.size.nil? || account_update_params['avatar'].nil?
      if @user.update(account_update_params)
        redirect_to @user
      else
        render 'devise/registrations/edit'
      end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :info, :phone, :skype, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :info, :phone, :skype, :avatar, :role)
  end
end
