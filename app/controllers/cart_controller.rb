class CartController < ApplicationController
  before_action :get_cart

  def index
  end

  def checkout
  end

  def order
    @cart_items.each { |item| item.destroy }
    redirect_to cart_index_path, notice: "Order has been shipped."
  end

  private
  def get_cart
    @cart_items = current_user.cart.all
  end
end
