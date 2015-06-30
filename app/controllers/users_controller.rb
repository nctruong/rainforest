class UsersController < ApplicationController
  before_filter :ensure_logged_out, only: [:new]

  def new
    @user = User.new
  end

  def createn
    @user = User.new(user_params)

    if @user.save
      redirect_to products_url, notice: "Sign up successful!"
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
