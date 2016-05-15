class SupplyAdjust < ActiveRecord::Base
  belongs_to :supply
  validates :amount, numericality: { only_integer: true}
  validates :supply, :presence => true
end
