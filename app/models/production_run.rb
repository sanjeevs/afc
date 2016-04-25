class ProductionRun < ActiveRecord::Base
  # A production run produces a single product and has a single producer.
  # Both must always be valid.
  belongs_to :producer
  belongs_to :product

  has_many :supply_consumptions
  has_many :supplies, :through => :supply_consumptions

  validates :amount, numericality: { greater_than_or_equal_to: 0}
  validates :producer, :presence => true
  validates :product, :presence => true
end
