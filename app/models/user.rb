class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: { case_sensitive: false } 

  has_many :product_adjusts, dependent: :destroy
  has_many :supply_adjusts, dependent: :destroy
end
