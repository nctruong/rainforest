class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def ensure_logged_in
    unless current_user
      session[:return_to] ||= request.fullpath
      redirect_to new_session_url, alert: "You need to be logged in to view this page"
    end
  end

  def ensure_logged_out
    unless current_user.nil?
      redirect_to products_url
    end
  end

end
