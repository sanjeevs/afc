class Supply < ActiveRecord::Base
  validates :amount, numericality: { greater_than_or_equal_to: 0}
  validates :name, presence: true, uniqueness: { case_sensitive: false } 

  has_many :supply_receiveds, dependent: :destroy
  has_many :supply_adjusts, dependent: :destroy

  has_many :supply_consumptions, dependent: :destroy
  has_many :production_runs, :through => :supply_consumptions
end
