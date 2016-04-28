require 'rails_helper'

describe SupplyAdjust do
  before { @supply_adjust = FactoryGirl.create(:supply_adjust) }

  subject { @supply_adjust }

  it { should be_valid }
  
  describe "supply nil" do
    before { @supply_adjust.supply_id = 0; }
    it { should_not be_valid }
  end


  describe "amount should not be 0" do
    before { @supply_adjust.amount = 0 }
    it { expect(@supply_adjust.valid?).to eql(false) }
  end

end
