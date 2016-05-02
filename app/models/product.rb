class Product < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false} 
  validates :amount, numericality: { greater_than_or_equal_to: 0}

  has_many :production_runs, dependent: :destroy
  has_many :product_shipments, dependent: :destroy
  has_many :product_returns, dependent: :destroy
  has_many :product_adjusts, dependent: :destroy
   
  after_initialize :set_defaults

  def set_defaults
    self.amount = 0 if self.new_record?
  end

  def total_production_amount
    production_runs.sum(:amount)
  end

  def total_shipments
    product_shipments.sum(:amount)
  end

  def total_returns
    product_returns.sum(:amount)
  end

  def total_adjusts
    product_adjusts.sum(:amount)
  end

  # For all operations the following condition must hold
  # ProductAmount + ProductAdjust = ProductShipment - ProductReturn + amount
  def is_amount_valid? 
    #puts "Total production=#{total_production_amount} with adjust=#{total_adjusts} that has #{total_shipments} shipments and #{total_returns} returns is left with #{amount} in product inventory."
    if((total_production_amount + total_adjusts) !=
                   (total_shipments - total_returns + amount)) 
      errors.add(:amount, 
        "Consistent check fails. Total production=#{total_production_amount} with adjust=#{total_adjusts} that has #{total_shipments} shipments and #{total_returns} returns is left with #{amount} in product inventory.")
      return false
    end

    if (total_shipments < total_returns) 
      errors.add(:amount, 
             "Total  #{total_shipments} shipments is less than #{total_returns} returns")
      return false
    end
    return true
  end

end
