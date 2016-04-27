require 'rails_helper'

describe SupplyConsumption do
  before { @supply_consumption = FactoryGirl.create(:supply_consumption) }
  subject { @supply_consumption }
  it { should be_valid }

  describe "amount nil" do
    before { @supply_consumption.amount = " " }
    it { should_not be_valid }
  end

end
