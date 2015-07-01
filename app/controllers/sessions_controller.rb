class SessionsController < ApplicationController
  before_action :ensure_logged_out, :return_path, only: [:new]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:return_to].nil?
        redirect_to products_url, notice: "Welcome back!"
      else
        redirect_to session.delete(:return_to), notice: "Welcome back!"
      end
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to products_url, notice: "Log out successful."
  end
end
