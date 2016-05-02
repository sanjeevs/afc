require 'rails_helper'

describe UpdateProductAmount do
  before do
    @product = FactoryGirl.create(:real_product)
  end

  it { expect(@product.production_runs.length).to eql(5) }
  it { expect(@product.amount).to eql(500) }
  it { expect(@product.product_returns[4].amount).to eql(20) }
  it { expect(@product.product_shipments[4].amount).to eql(120) }


  describe "increase product return"  do
    before do
      @result = UpdateProductAmount.incr(@product.product_returns[4], 30)
    end
    it { expect(@result.success?).to eql(true) }
    it { expect(@product.amount).to eql(510) }
  end

  describe "decrease product return"  do
    before do
      @result = UpdateProductAmount.incr(@product.product_returns[4], 1)
    end
    it { expect(@result.success?).to eql(true) }
    it { expect(@product.amount).to eql(481) }
  end

  describe 'invalid product return amount' do
    before do
      @result = UpdateProductAmount::incr(@product.product_returns[3], 600)
    end

    it { expect(@result.success?).to eql(false) }
    # FIXME: This reports the value ot be 600. but if we load from db then it is fine.
    #it { expect(@product.product_returns[3].amount).to eql(20) }
    it { expect(ProductReturn.find(@product.product_returns[3].id).amount).to eql(20) }
    it { expect(@product.product_shipments[3].amount).to eql(120) }
  end

end

