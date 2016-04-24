class Product < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false} 
  validates :amount, numericality: { greater_than_or_equal_to: 0}

  has_many :production_run, dependent: :destroy
  has_many :product_shipment, dependent: :destroy
  has_many :product_return, dependent: :destroy
  has_many :product_adjust, dependent: :destroy
   
  after_initialize :set_defaults

  def set_defaults
    self.amount = 0 if self.new_record?
  end
end
