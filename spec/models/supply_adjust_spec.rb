require 'rails_helper'

describe SupplyAdjust do
  before { @supply_adjust = FactoryGirl.create(:supply_adjust) }

  subject { @supply_adjust }

  it { should be_valid }
  
  describe "supply nil" do
    before { @supply_adjust.supply_id = 0; }
    it { should_not be_valid }
  end


  describe "amount can be -ve" do
    before { @supply_adjust.amount = -1 }
    it { expect(@supply_adjust.valid?).to eql(true) }
  end

end
