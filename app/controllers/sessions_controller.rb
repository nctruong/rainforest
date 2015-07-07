class SessionsController < ApplicationController
  before_action :ensure_logged_out, only: [:new]

  def new
    session[:advance_to] ||= request.referer
    # Bug: Since return_path does not overwrite, from 'New Product' -> Login (without logging in), back to 'View Product' -> 'Login' to comment,
    # redirects to 'New Product'

    # Bug Fix: Overwrite session[:advance_to] when loading 'Show Product'
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to session.delete(:advance_to), notice: "Welcome back!"
    else
      flash.now[:alert] = "Invalid username or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to products_url, notice: "Log out successful."
  end
end
