class SupplyAdjust < ActiveRecord::Base
  belongs_to :supply
  belongs_to :user
  validates :amount, numericality: { only_integer: true}
  validates :supply, :presence => true
end
