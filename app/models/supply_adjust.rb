class SupplyAdjust < ActiveRecord::Base
  belongs_to :supply
  belongs_to :user
  validates :amount, numericality: { greater_than: 0}
  validates :supply, :presence => true
end
