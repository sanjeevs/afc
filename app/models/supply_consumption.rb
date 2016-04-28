class SupplyConsumption < ActiveRecord::Base
  belongs_to :supply
  belongs_to :production_run
  
  validates :amount, numericality: { greater_than_or_equal_to: 0}
  validates :supply, :presence => true

  
end
