class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  def tax
    tax = unit_price * 0.13
    tax
  end
end
