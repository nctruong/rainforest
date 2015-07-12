class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :products, through: :reviews

  has_many :merchandise, class_name: "Product", foreign_key: "seller_id", dependent: :destroy

  has_many :buttons, dependent: :destroy
  has_many :orders, through: :buttons, source: :product

  has_many :cart_items, dependent: :destroy do
    def add(product)
      cart_item = new(product: product)
      cart_item.unit_price = product.price
      cart_item.save
      cart_item
    end
  end
  alias_method :cart, :cart_items

  validates :first_name, :last_name, :username, :email, presence: true
  validates :username, :email, uniqueness: { message: "is already in use" }

  has_secure_password

end
