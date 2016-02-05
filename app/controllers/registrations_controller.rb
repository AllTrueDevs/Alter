class RegistrationsController < Devise::RegistrationsController
  def update
    respond_to do |format|
      if @user.update(account_update_params)
        format.html { redirect_to @user }
      else
        format.html { redirect_to edit_user_registration_path}
      end
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
