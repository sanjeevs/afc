class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }

  before_save :create_remember_token

  # do not delete the adjusts just because the user is deleted.
  has_many :product_adjusts
  has_many :supply_adjusts

  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
