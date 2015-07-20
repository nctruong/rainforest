class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  def tax
    tax = unit_price * 0.13
    tax
  end

  def formatted_price
    sprintf("%.2f", unit_price)
  end
end
