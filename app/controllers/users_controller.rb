class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end


end
