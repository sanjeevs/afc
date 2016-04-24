class ProductAdjust < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  validates :amount, numericality: { greater_than: 0}
end
