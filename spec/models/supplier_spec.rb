require 'rails_helper'

describe Supplier do
  before { @supplier = Supplier.new(name: "Example",
                                    email: "user@example.org") }
  subject { @supplier }
  it { should be_valid }

  describe 'when name is not present' do
    before { @supplier.name = " " }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @supplier.name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when name is already taken' do
    before do
      supplier_with_same_name = @supplier.dup
      supplier_with_same_name.name = @supplier.name.upcase
      supplier_with_same_name.save
    end
    it { should_not be_valid }
  end

  describe "supply received" do
    before do
      @supply = Supply.create!(name: "xyz", unit: "kg", amount: 200)
      supply_rcvd = SupplyReceived.create(amount: 102)
      @supply.supply_received << supply_rcvd
      @supplier.supply_received << supply_rcvd
    end
    it { expect(@supplier.supply_received[0].amount).to eql(102) }
  end

end
