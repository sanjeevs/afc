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
      supplier_with_same_name.save
    end
    it { should_not be_valid }
  end

end
