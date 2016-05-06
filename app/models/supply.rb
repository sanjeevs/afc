class Supply < ActiveRecord::Base
  validates :amount, numericality: { greater_than_or_equal_to: 0}
  validates :name, presence: true, uniqueness: { case_sensitive: false } 

  has_many :supply_receiveds, dependent: :destroy
  has_many :supply_adjusts, dependent: :destroy

  has_many :supply_consumptions, dependent: :destroy
  has_many :production_runs, :through => :supply_consumptions

  after_initialize :set_defaults

  def set_defaults
    self.amount = 0 if self.new_record?
  end

  def total_received
    supply_receiveds.sum(:amount)
  end

  def total_adjusts
    supply_adjusts.sum(:amount)
  end

  def total_consumptions
    supply_consumptions.sum(:amount)
  end

  # For all operations this condition must be true.
  # SupplyReceived + SuppyAdjust = Supply - SupplyConsumed
  def is_amount_valid?
    if((total_received + total_adjusts) != (amount + total_consumptions))
      errors.add(:amount,
      "Consistent check fails. Total received=#{total_received},"\
      "TotalAdjusts=#{total_adjusts},TotalAmount=#{amount},"\
      "TotalConsumptions=#{total_consumptions}")
      return false
    end
    # Adjust requires us to make sure that this is true.
    if(total_received < total_consumptions) 
      errors.add(:amount,
      "Consistent check fails. Total received=#{total_received},"\
      "TotalConsumptions=#{total_consumptions}")
      return false
    end
    return true
  end
end
