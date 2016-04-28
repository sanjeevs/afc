require 'rails_helper'

describe SupplyConsumption do
  before { @supply_consumption = FactoryGirl.create(:supply_consumption) }
  subject { @supply_consumption }
  it { should be_valid }

  describe "supply nil" do
    before { @supply_consumption.supply_id = 0; }
    it { should_not be_valid }
  end

  describe "amount nil" do
    before { @supply_consumption.amount = " " }
    it { should_not be_valid }
  end

end
