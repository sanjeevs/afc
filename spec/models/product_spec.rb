require 'rails_helper'

describe Product do
  before { @product = Product.new(name: 'zukti') }

  subject { @product }
  it { should be_valid }

  describe "default amount" do
    it { expect(@product.amount).to eq(0) }
  end

  describe "name blank" do
    before { @product.name = "" }
    it { should_not be_valid }
  end

  describe "amount negative" do
    before { @product.amount = -1 }
    it { should_not be_valid }
  end

  describe "name should be unique" do
    before do
      dup_product = @product.dup
      dup_product.save
    end
    it { expect(@product.valid?).to eql(false) }
  end

  describe "production_run assocations" do
    it "should destroy associated runs" do
      production_run = FactoryGirl.create(:production_run)
      Product.destroy(production_run.product_id)
      expect(ProductionRun.find_by_id(production_run.id)).to be_nil
    end
  end
end
