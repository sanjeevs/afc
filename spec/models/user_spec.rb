require 'rails_helper'

describe User do 
  before { @user = FactoryGirl.create(:user) }
  subject { @user }
  it { should be_valid }

  describe 'email must be unique' do
    before do
      @duplicate_user = @user.dup
      @duplicate_user.email = @user.email.upcase
    end
    it { expect(@duplicate_user.valid?).to eql(false) }
  end

end
