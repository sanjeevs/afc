require 'ostruct'
require_relative "exceptions"

# Changes product amount due to various operations.
# For all operations the following condition must hold
# ProductAmount + ProductAdjust = ProductShipment - ProductReturn

class UpdateProductAmount;

  # Change the amount produced in the production run.
  # Return result object with success? and the new production run record.
  def production_run_update(production_run_id, new_amount)
    result = OpenStruct.new(success?: true, errors: [])
    production_run = ProductionRun.find(production_run_id)
    result.production_run = production_run
    product = production_run.product 
    
    orig_amount = production_run.amount
    production_run.amount = new_amount
    product.amount = product.amount - orig_amount + new_amount
   
    ActiveRecord::Base.transaction do
      raise MyAppError::ProductAmountError.new unless product.is_amount_valid?
      production_run.save!
      product.save!
    end

    result
    rescue MyAppError::MyAssertError => e 
      result.send("success?=", false)
      result.errors << e.message
  end
end
