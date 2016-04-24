class Supplier < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  before_save { |supplier| supplier.name = name.titleize }

  has_many :supply_received
end
