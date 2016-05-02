require 'ostruct'
require_relative "exceptions"

# Changes product amount due to various operations.
# For all operations the following condition must hold
# ProductAmount + ProductAdjust = ProductShipment - ProductReturn

class UpdateProductAmount;

  def self.incr(record, new_amount)
    self.update(:incr, record, new_amount)
  end

  def self.decr(record, new_amount)
    self.update(:decr, record, new_amount)
  end

  # Change the amount produced in the production run.
  # Return result object with success? and the new production run record.
  def self.update(op, record, new_amount)
    result = OpenStruct.new(success?: true, errors: [])
    product = record.product 
   
    change = new_amount - record.amount
    product.amount += change if op == :incr
    product.amount -= change if op == :decr
    record.amount = new_amount

    ActiveRecord::Base.transaction do
      record.save!
      product.save!
      raise MyAppError::ProductAmountError.new unless product.is_amount_valid?
    end

    result
    rescue MyAppError::MyAssertError => e 
      result.send("success?=", false)
      result.errors << e.message
      record.errors.add(:amount, e.message)
      result
  end
end
