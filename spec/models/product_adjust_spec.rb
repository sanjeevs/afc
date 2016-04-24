require 'rails_helper'

describe ProductAdjust do
  before { @product_adjust = FactoryGirl.create(:product_adjust) }

  subject { @product_adjust }

  it { should be_valid }

  describe "amount should not be 0" do
    before { @product_adjust.amount = 0 }
    it { expect(@product_adjust.valid?).to eql(false) }
  end

  describe "associations" do
    it { expect(@product_adjust.product.name).to eql("piaz") }
    it { expect(@product_adjust.user.name).to eql("user1") }
  end
end
