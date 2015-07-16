class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates :comments, presence: true
end
