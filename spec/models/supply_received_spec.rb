require 'rails_helper'

describe SupplyReceived do
  before { @supply_received = FactoryGirl.create(:supply_received) }
  subject { @supply_received }

  it { should be_valid }

  describe "amount is empty" do
    before { @supply_received.amount = " " }
    it { should_not be_valid }
  end

  describe "supplier association" do
    let(:supplier) { Supplier.find(@supply_received.supplier_id) }
    it { expect(@supply_received.supplier.name).to eql(supplier.name) }
  end

  describe "supply association" do
    let(:supply) { Supply.find(@supply_received.supply_id) }
    it { expect(@supply_received.supply.amount).to eql(supply.amount) }
  end

end
