class RegistrationsController < Devise::RegistrationsController
  def update
      if @user.update(account_update_params)
        respond_to do |format|
          format.html { redirect_to @user, notice: 'Зміни успішно внесено' }
        end
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
