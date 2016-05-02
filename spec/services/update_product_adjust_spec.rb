require 'rails_helper'

describe UpdateProductAmount do
  before do
    @product = FactoryGirl.create(:real_product)
  end

  it { expect(@product.production_runs.length).to eql(5) }
  it { expect(@product.amount).to eql(500) }
  it { expect(@product.product_adjusts[4].amount).to eql(1) }
  it { expect(@product.product_shipments[4].amount).to eql(120) }


  describe "increase product adjust"  do
    before do
      @result = UpdateProductAmount.incr(@product.product_adjusts[4], 30)
    end
    it { expect(@result.success?).to eql(true) }
    it { expect(@product.amount).to eql(529) }
  end

  describe "decrease product adjust"  do
    before do
      @result = UpdateProductAmount.incr(@product.product_adjusts[4], -30)
    end
    it { expect(@result.success?).to eql(true) }
    it { expect(@product.amount).to eql(469) }
  end

  describe 'invalid product return adjust' do
    it do
      expect {
         UpdateProductAmount::incr(@product.product_adjusts[3], -600)
      }.to raise_exception ActiveRecord::RecordInvalid
    end

    it { expect(@product.product_adjusts[3].amount).to eql(1) }
    it { expect(@product.product_shipments[3].amount).to eql(120) }
  end

end

