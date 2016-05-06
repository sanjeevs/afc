require 'rails_helper'

describe User do 
  before { @user = FactoryGirl.create(:user) }
  subject { @user }
  it { should be_valid }
  it { should respond_to(:authenticate) }

  let(:found_user) { User.find_by_email(@user.email) }

  describe 'email must be unique' do
    before do
      @duplicate_user = @user.dup
      @duplicate_user.email = @user.email.upcase
    end
    it { expect(@duplicate_user.valid?).to eql(false) }
  end

  describe "name must be present" do
    before { @user.name = "   " }
    it { expect(@user).not_to be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password confirmation is not nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "when password confirmaton mismatches" do
    before { @user.password_confirmation = "mismatch"}
    it { should_not be_valid }
  end

 describe "with valid password" do
  it { expect(found_user.authenticate(@user.password)).to eql @user }
 end

 describe "with invalid password" do
  it { expect(found_user.authenticate('mismatch')).to eql false}
 end
end
