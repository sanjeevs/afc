require 'rails_helper'

describe ProductShipment do
  before { @product_shipment = FactoryGirl.create(:product_shipment) }

  subject { @product_shipment }

  it { should be_valid }

  describe "amount must be greater than 0" do
    before { @product_shipment.amount = 0 }
    it { expect(@product_shipment.valid?).to eql(false) }
  end

  describe "product nil" do
    before { @product_shipment.product_id = 0; }
    it { should_not be_valid }
  end

  describe "assocations" do
    let(:product) { Product.find(@product_shipment.product_id) }
    let(:customer) { Customer.find(@product_shipment.customer_id) }

    it { expect(@product_shipment.product.name).to eql(product.name) }
    it { expect(@product_shipment.customer.name).to eql(customer.name) }
  end

end
