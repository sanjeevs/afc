require 'rails_helper'

describe ProductReturn do
  before { @product_return = FactoryGirl.create(:product_return) }

  subject { @product_return }

  it { should be_valid }

  describe "amount must be greater than 0" do
    before { @product_return.amount = 0 }
    it { expect(@product_return.valid?).to eql(false) }
  end

  describe "assocations" do
    it { expect(@product_return.product.name).to eql('piaz') }
    it { expect(@product_return.customer.name).to eql('Customer1') }
  end

end
