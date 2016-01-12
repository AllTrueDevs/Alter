class RegistrationsController < Devise::RegistrationsController

  def create
    @new_user = User.new(sign_up_params)
    @new_user.contacts = [params[:phone], params[:skype], params[:facebook], params[:vk]].join('|')
    @new_user.save

    redirect_to root_path
  end

private

  def sign_up_params
    params.require(:user).permit(:name, :info, :contacts, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :info, :contacts, :email, :password, :password_confirmation, :current_password)
  end

end
