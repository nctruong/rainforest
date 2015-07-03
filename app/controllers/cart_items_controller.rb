class CartItemsController < ApplicationController
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_index_path
  end
end
