class CartController < ApplicationController
  before_action :ensure_logged_in
  before_action :get_cart

  def index
  end

  def checkout
  end

  def delete
    remove_all
    redirect_to cart_index_path
  end

  def order
    remove_all
    redirect_to cart_index_path, notice: "Order has been shipped."
  end

  private
  def get_cart
    @cart_items = current_user.cart.all
  end

  def remove_all
    @cart_items.each { |item| item.destroy }
  end
end
