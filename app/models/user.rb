class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :merchandise, class_name: "Product", foreign_key: "seller_id", dependent: :destroy
  has_many :products, through: :reviews

  validates :first_name, :last_name, :username, :email, presence: true
  validates :username, :email, uniqueness: { message: "is already in use" }

  has_secure_password
end
