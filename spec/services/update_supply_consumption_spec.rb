require 'rails_helper'

describe UpdateSupplyAmount do
  before do
    @supply = FactoryGirl.create(:real_supply)
  end

  it { expect(@supply).to be_valid }
  it { expect(@supply.total_received).to eql(330) }
  it { expect(@supply.total_adjusts).to eql(-3) }
  it { expect(@supply.total_consumptions).to eql(33) }
  it { expect(@supply.amount).to eql(294) }
  it { expect(@supply.is_amount_valid?).to eql(true) }

  describe "invalid amount in supply" do
    before do 
      @supply.amount = 99
   end
   it { expect(@supply.is_amount_valid?).to eql(false) }
  end  

  describe "invalid consumption in supply" do
    before do
      @supply.supply_adjusts.each do |adjust|
        adjust.amount = 10
        adjust.save!
      end
      @supply.amount = 0
      @supply.supply_consumptions.each do |consumption|
        consumption.amount = 120
        consumption.save!
      end
    end

    it { expect(@supply.is_amount_valid?).to eql(false) }
  end

end

