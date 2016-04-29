require 'ostruct'

# Changes product amount due to various operations.
# For all operations the following condition must hold
# ProductAmount + ProductAdjust = ProductShipment - ProductReturn

class UpdateProductAmount;

  # Change the amount produced in the production run.
  # Return result object with success? and the new production run record.
  def production_run_update(production_run_id, new_amount)
    result = OpenStruct.new(success?: true, errors: [])
    production_run = ProductionRun.find(production_run_id)
    product = production_run.product 
    
    orig_amount = production_run.amount
    production_run.amount = new_amount
    product.amount = product.amount - orig_amount + new_amount
    
    # Apply the golden check.
    unless product.is_amount_valid? 
      result.send("success?=", false)
      result.errors << "Specified amount #{new_amount}"\
                       " makes the product amount invalid"
    end

    if result.success?
      ActiveRecord::Base.transaction do
        production_run.save!
        product.save!
      end
      result.production_run = production_run
    end

    result
  end
end

