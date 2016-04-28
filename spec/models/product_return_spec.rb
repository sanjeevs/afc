require 'rails_helper'

describe ProductReturn do
  before do
    @product_return = FactoryGirl.create(:product_return) 
  end

  subject { @product_return }

  it { should be_valid }

  describe "amount must be greater than 0" do
    before { @product_return.amount = 0 }
    it { expect(@product_return.valid?).to eql(false) }
  end

  describe "product nil" do
    before { @product_return.product_id = 0; }
    it { should_not be_valid }
  end

  describe "assocations" do
    let(:customer) { Customer.find(@product_return.customer_id) }
    let(:product) { Product.find(@product_return.product_id) }
    it { expect(@product_return.product.name).to eql(product.name) }
    it { expect(@product_return.customer.name).to eql(customer.name) }
  end

end
