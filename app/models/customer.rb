class Customer < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  before_save { |customer| customer.name = name.titleize }

  has_many :product_shipments, dependent: :destroy
  has_many :product_returns, dependent: :destroy
end
