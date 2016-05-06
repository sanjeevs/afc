require 'rails_helper'

describe Supply do
  before { @supply = FactoryGirl.create(:supply) }
  subject { @supply }

  it { should be_valid }

  describe "defaut amount" do
    before { @new_supply = Supply.create!(name: 'dummy') }
    it { expect(@new_supply.amount).to eql 0 }
  end

  describe 'nil amount' do
    before { @supply.amount = nil }
    it { expect(@supply.valid?).to eq(false) }
  end

  describe "when name is not present" do
    before { @supply.name = " " }
    it { should_not be_valid }
  end

  describe 'duplicate name' do
    before do
      @dup_supply = @supply.dup
      @dup_supply.name = @supply.name.upcase
    end
    it {expect(@dup_supply.valid?).to eql(false) }
  end

  describe "has many assocation with supply_received" do
    before do
      @supply.supply_receiveds << SupplyReceived.new(amount: 10)
    end
    it { expect(@supply.supply_receiveds[0].amount).to eql(10) }
  end

  describe "has many assocation with production run" do
    before do
      @pr = FactoryGirl.create(:production_run)
      @supply_consumption = SupplyConsumption.create!(
                                  supply_id: @supply.id,
                                  production_run_id: @pr.id,
                                  amount: 2)
    end
    it { expect(@supply.production_runs[0].amount).to eql(@pr.amount) }
    it { expect(@supply.supply_consumptions[0].amount).to eql(@supply_consumption.amount) }
  end

end
