class Customer < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  before_save { |customer| customer.name = name.titleize }

  has_many :product_shipment, dependent: :destroy
  has_many :product_return, dependent: :destroy
end
