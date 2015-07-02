class UsersController < ApplicationController
  before_action :get_current_user, except: [:new, :create]
  before_action :ensure_logged_out, only: :new
  before_action :ensure_logged_in, except: [:new, :create]

  def index
  end

  def user_products
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to products_url, notice: "Sign up successful!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @seller.update_attributes(user_params)
      redirect_to user_url(@seller)
    else
      render :edit
    end
  end

  def destroy
    @seller.destroy
    session[:user_id] = nil
    redirect_to products_url
  end

  private
  def get_current_user
    @seller = User.find(current_user.id)
  end
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end
end
