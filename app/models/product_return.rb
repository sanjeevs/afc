class ProductReturn < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer
  validates :amount, numericality: { greater_than: 0}
end
