class CartController < ApplicationController

  def index
    @cart_items = current_user.cart.all
  end

  def destroy
  end

  def checkout!
  end

  def ship!
  end
end
