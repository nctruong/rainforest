class ButtonsController < ApplicationController
  before_action :ensure_logged_in

  def index
    @access_token = access_token
    @my_buttons = HTTParty.get('https://api.particle.io/v1/devices', query: {access_token: @access_token})
  end

  def products
    @products = Product.where.not(seller: current_user).order(created_at: :desc)
  end

  def login
  end

  def authenticate
    params.except!(:utf8, :authenticity_token, :commit, :controller, :action)
    @@access_token = HTTParty.post('https://api.particle.io/oauth/token', body: params)["access_token"]

    if @@access_token == nil
      redirect_to user_buttons_url, alert: "Username or password was incorrect. Please try again."
    else
      redirect_to user_buttons_url
    end
  end

  def create
    @button = current_user.buttons.new(core_id: params[:core_id], access_token: "@@access_token")
    @button.user = current_user

    if @button.save
      redirect_to user_buttons_url, notice: "Button added successfully"
    else
      render user_buttons_url, alert: "An error occurred"
    end
  end

  def logout
    @@access_token = nil
    redirect_to user_buttons_url
  end

  private
  def access_token
    @@access_token ||= nil
  end

  def registered?(id)
    Button.exists?(core_id: id)
  end
end
