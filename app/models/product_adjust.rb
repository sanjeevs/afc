class ProductAdjust < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  validates :amount, numericality: { only_integer: true}
  validates :product, :presence => true
end
