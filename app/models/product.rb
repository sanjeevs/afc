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

end
