require 'rails_helper'

describe UpdateProductAmount do
  before do
    @product = FactoryGirl.create(:real_product)
  end


  describe "increase product return"  do
    it { expect(@product.production_runs.length).to eql(5) }
  end


end

