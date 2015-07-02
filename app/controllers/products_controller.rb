class ProductsController < ApplicationController
  before_action :get_product, only: [:show, :update, :destroy]
  before_action :ensure_logged_in, only: [:new]

  def index
    advance_to_path
    # work around for now for 'show'

    @products = Product.order(created_at: :desc)
  end

  def show
    advance_to_path

    if current_user
      @review = @product.reviews.build
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(product_params)

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
    params.require(:product).permit(:product, :description, :price)
  end
end
