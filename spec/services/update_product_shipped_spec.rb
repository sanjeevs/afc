require 'rails_helper'

describe UpdateProductAmount do
  before do
    @product_shipment = FactoryGirl.create(:product_shipment)
  end

  it { expect(@product_shipment.valid?).to eql true }

  describe "increase product shipment" do
    before do
      @product_shipment.amount = 121
      @proudct_shipment.product.amount = 200
      @product_shipment.save!
    end
  end

end

