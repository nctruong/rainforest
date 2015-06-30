class Product < ActiveRecord::Base
  validates :description, :name, presence: true
  validates :price_in_cents, numericality: {only_integer: true}

  def price_in_dollars
    price_in_dollars = price_in_cents / 100.0
    sprintf("%.2f", price_in_dollars)
  end
end
