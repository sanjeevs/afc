require 'rails_helper'

describe Producer do
  before { @producer = Producer.new(name: "Example",
                                    email: "user@example.org") }
  subject { @producer }
  it { should be_valid }

  describe 'when name is not present' do
    before { @producer.name = " " }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @producer.name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when name is already taken' do
    before do
      producer_with_same_name = @producer.dup
      producer_with_same_name.save
    end
    it { should_not be_valid }
  end

end
