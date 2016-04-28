require 'ostruct'

# Adds product amount due to various operations.
class AddProductAmount;

  # Increase the product amount due to production run.
  # Returns the product record saved.
  def production_run(id, new_amount)
    raise ArgumentError, "Amount is negative" unless new_amount >= 0
    
    result = OpenStruct.new(success?: true, errors: [])
    prod_run = ProductionRun.find(id)  
    
    if(new_amount < prod_run.amount && new_amount < prod_run.product.amount) 
      result.send("success?=", false)
      result.errors << "Specified amount #{new_amount} in production_run makes product" +  
              "amount #{prod_run.product.amount} negative"
    elsif(new_amount > prod_run.amount)
      prod_run.product.amount += (new_amount - prod_run.amount)
      prod_run.amount = new_amount
    else 
      prod_run.product.amount -= (prod_run.amount - new_amount)
      prod_run.amount = new_amount
    end

    if(result.success?)
      puts "SPS:Saving the records prod_run.amount=#{prod_run.amount}"
      puts "SPS:Saving the records prod.amount=#{prod_run.product.amount}"
      ActiveRecord::Base.transaction do
        prod_run.product.save!
        prod_run.save!
      end
      result.production_run = prod_run
    end
    return result 
  end

end
