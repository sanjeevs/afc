require 'rails_helper'

describe ProductionRun do

  let(:product) { FactoryGirl.create(:product) }
  let(:producer) { FactoryGirl.create(:producer) }

  before { @production_run = FactoryGirl.create(:production_run, product: product, producer: producer) }

  subject { @production_run }

  it { should be_valid }

  describe "amount negative" do
    before { @production_run.amount = -1 }
    it { should_not be_valid }
  end

  describe "when product_id is not present" do
   before { @production_run.product_id = nil}
   it { should_not be_valid }
  end

  describe "when producer_id is not present" do
   before { @production_run.producer_id = nil}
   it { should_not be_valid }
  end

end
