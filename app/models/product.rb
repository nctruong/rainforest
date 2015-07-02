class Product < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  belongs_to :user
  # has_many :users, through: :reviews
  # before_destroy { |product| Review.destroy_all "product_id = #{product.id}" }

  validates :description, :product, presence: true
  validates :price, format: { with: /\A[+]?(\d+|\d+\.\d{1,2})\Z/, message: "is in the wrong format [ $ 0.00 ]" }

  def formatted_price
    sprintf("%.2f", price)
  end
end
