require 'rails_helper'

describe Customer do
  before { @customer = Customer.new(name: "Example", 
                                    email: "user@example.com") }
  subject { @customer }

  it { should be_valid }

  describe 'when name is not present' do
    before { @customer.name = " " }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @customer.name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when name is already taken' do
    before do
      customer_with_same_name = @customer.dup
      customer_with_same_name.save
    end
    it { should_not be_valid }
  end

end
