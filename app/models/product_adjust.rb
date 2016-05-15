class ProductAdjust < ActiveRecord::Base
  belongs_to :product
  validates :amount, numericality: { only_integer: true}
  validates :product, :presence => true
end
