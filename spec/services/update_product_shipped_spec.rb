require 'rails_helper'

describe UpdateProductAmount do
  before do
    @product_shipment = FactoryGirl.create(:product_shipment)
  end

  it { expect(@product_shipment.valid?).to eql true }

  describe "increase product shipment" do
    before do
      @product_shipment.amount = 121
      @product_shipment.product.amount = 200
      @product_shipment.save!
      @result = UpdateProductAmount::decr(@product_shipment, 150)
    end

    it { expect(@product_shipment.amount).to eql(150) }
    it { expect(@product_shipment.product.amount).to eql(200 - (150 - 121)) }
  end

  describe "decrease product shipment" do
    before do
      @product_shipment.amount = 121
      @product_shipment.product.amount = 200
      @product_shipment.save!
      @result = UpdateProductAmount::decr(@product_shipment, 100)
    end

    it { expect(@product_shipment.amount).to eql(100) }
    it { expect(@product_shipment.product.amount).to eql(200 - (100 - 121)) }
  end

  describe "invalid product shipment" do
    before do
      @product_shipment.amount = 121
      @product_shipment.product.amount = 200
      @product_shipment.save!
    end
    it do
      expect {
         UpdateProductAmount::decr(@product_shipment, 121+201+1)
      }.to raise_exception ActiveRecord::RecordInvalid
    end

    it { expect(@product_shipment.amount).to eql(121) }
    it { expect(@product_shipment.product.amount).to eql(200) }
  end

end

