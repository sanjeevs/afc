require 'rails_helper'

describe ProductShipment do
  before { @product_shipment = FactoryGirl.create(:product_shipment) }

  subject { @product_shipment }

  it { should be_valid }

  describe "amount must be greater than 0" do
    before { @product_shipment.amount = 0 }
    it { expect(@product_shipment.valid?).to eql(false) }
  end

  describe "assocations" do
    it { expect(@product_shipment.product.name).to eql('piaz') }
    it { expect(@product_shipment.customer.name).to eql('Customer1') }
  end

end
