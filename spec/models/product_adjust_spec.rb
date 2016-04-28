require 'rails_helper'

describe ProductAdjust do
  before { @product_adjust = FactoryGirl.create(:product_adjust) }

  subject { @product_adjust }

  it { should be_valid }

  describe "amount can be negative" do
    before { @product_adjust.amount = -1 }
    it { expect(@product_adjust.valid?).to eql(true) }
  end

  describe "product nil" do
    before { @product_adjust.product_id = 0 }
    it { expect(@product_adjust.valid?).to eql(false) }
  end

  describe "associations" do
    let(:product) { Product.find(@product_adjust.product_id) }
    let(:user) { User.find(@product_adjust.user_id) }
    it { expect(@product_adjust.product.name).to eql(product.name) }
    it { expect(@product_adjust.user.name).to eql(user.name) }
  end
end
