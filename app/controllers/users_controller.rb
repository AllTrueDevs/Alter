class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :create, :destroy, :new, :update]

end
