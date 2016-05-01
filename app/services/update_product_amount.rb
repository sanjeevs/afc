require 'ostruct'
require_relative "exceptions"

# Changes product amount due to various operations.
# For all operations the following condition must hold
# ProductAmount + ProductAdjust = ProductShipment - ProductReturn

class UpdateProductAmount;

  # Change the amount produced in the production run.
  # Return result object with success? and the new production run record.
  def incr(record, new_amount)
    result = OpenStruct.new(success?: true, errors: [])
    product = record.product 
   
    change = new_amount - record.amount
    product.amount += change
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
  end
end
