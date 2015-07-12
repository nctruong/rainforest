class Product < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  belongs_to :seller, class_name: "User"
  has_many :cart_items

  has_many :buttons, dependent: :destroy
  has_many :customers, through: :buttons, source: :user

  validates :description, :name, presence: true
  validates :price, format: { with: /\A[+]?(\d+|\d+\.\d{1,2})\Z/, message: "is in the wrong format [ $ 0.00 ]" }

  def formatted_price
    sprintf("%.2f", price)
  end
end
