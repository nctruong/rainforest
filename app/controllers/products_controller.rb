class ProductsController < ApplicationController
  before_action :get_product, only: [:show, :add_to_cart, :update, :destroy]
  before_action :ensure_logged_in, only: [:new, :add_to_cart]

  def index
    clear_path

    @products = if params[:search]
      Product.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search]}%")
    else
      Product.all.page(params[:page])
    end

    respond_to do |format|
      format.html do
        if request.xhr?
          render @products
        else
          render :index
        end
      end

      format.js do
        render :index
      end
    end

    # refactored from above
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  def show
    @review = Review.new(product: @product)
  end

  def add_to_cart
    if !current_user.merchandise.exists?(@product)
      if !in_cart(@product)
        @cart_item = current_user.cart.add(@product)
        redirect_to product_path(@product), notice: "#{ @product.name } was added to your cart."
      else
        redirect_to product_path(@product), alert: "#{ @product.name } already exists in your cart."
      end
    end
  end

  def add_to_button
    button = Button.find(params[:id])
    button.update_attributes(product_id: params[:product_id])
    redirect_to login_user_buttons_url(current_user), notice: "Button was tagged successfully"
  end

  def button_order
    button = Button.find_by(core_id: params[:core_id])

    if button
      core = RubySpark::Core.new(button.core_id, button.access_token)
      user = User.find(button.user_id)
      product = Product.find(button.product_id)
      user.cart.add(product)
      core.function("cartResponse", "success")
      redirect_to products_url, notice: "Item added to cart successfully with your button!"
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.merchandise.new(product_params)

    if @product.save
      redirect_to products_url
    else
      render :new
    end
  end

  def edit
    if authorized(current_user)
      get_product
    else
      redirect_to products_url
    end
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to product_url(@product)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url
  end

  private
  def authorized(user)
    user == Product.find(params[:id]).user
  end

  def get_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

  def in_cart(item)
    current_user.cart.exists?(product_id: item.id)
  end
end
