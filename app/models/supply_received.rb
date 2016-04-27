class SupplyReceived < ActiveRecord::Base
  validates :amount, numericality: { greater_than_or_equal_to: 0}
  belongs_to :supply
  belongs_to :supplier

end
