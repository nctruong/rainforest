class Product < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  validates :description, :name, presence: true
  validates :price_in_cents, format: { with: /\A[+]?(\d+|\d+\.\d{2})\Z/, message: "is in the wrong format [ $ 0.00 ]" }

  def formatted_price
    sprintf("%.2f", price_in_cents)
  end
end
