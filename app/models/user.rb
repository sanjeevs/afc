class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: { case_sensitive: false } 

  # do not delete the adjusts just because the user is deleted.
  # Instead we copy over the name and email of the user to adjust
  # for bookeeping.
  has_many :product_adjusts
  has_many :supply_adjusts
end
