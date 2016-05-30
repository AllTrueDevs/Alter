class RegistrationsController < Devise::RegistrationsController
  include AmazonModule

  def update
      previous_photo = [@user.avatar.size, @user.avatar.path]
      if @user.update(account_update_params)
        clear_s3_object(previous_photo[1]) unless previous_photo[0].nil? && account_update_params['avatar'].size.nil?
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
