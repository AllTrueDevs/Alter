class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(sign_up_params)
    @user.contacts = [params[:phone], params[:skype], params[:facebook], params[:vk]].join('|')
    @user.save

    redirect_to root_path
  end

  def edit
  end

  def update
    respond_to do |format|
      @user.contacts = [params[:phone], params[:skype], params[:facebook], params[:vk]].join('|')
      if @user.update(account_update_params)
        format.html { redirect_to root_path }
      else
        format.html { render :edit }
      end
    end
  end

private

  def sign_up_params
    params.require(:user).permit(:name, :info, :contacts, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :info, :contacts, :avatar)
  end

end
