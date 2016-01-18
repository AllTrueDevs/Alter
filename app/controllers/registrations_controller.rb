class RegistrationsController < Devise::RegistrationsController

  def create
    @new_user = User.new(sign_up_params)
    @new_user.role = 'admin' if User.count.zero?
    @new_user.skip_confirmation!
    @new_user.save!
    redirect_to root_path
  end

  def update
    respond_to do |format|
      if @user.update(account_update_params)
        format.html { redirect_to root_path }
      else
        format.html { render :edit }
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