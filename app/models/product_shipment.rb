class ProductShipment < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer
  validates :amount, numericality: { greater_than: 0}
  validates :product, :presence => true
end
