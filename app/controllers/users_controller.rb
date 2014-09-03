class UsersController < ApplicationController
  USER_ATTR = [:email, :username, :password, :password_confirmation]
  def new
    @user = User.new
  end

  def create
    @user = User.new(secure_params(:user, USER_ATTR))
    if @user.save 
      redirect_to products_path, notice: "Signed up!"
    else
      render 'new'
    end
  end
end
