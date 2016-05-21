require 'spec_helper'

# Make sure that security is implemented and redirection works.
describe "Customer pages" do
  subject { page }

  # Security
  describe "not public accessible " do
    let(:customer) { FactoryGirl.create(:customer) }
    let(:user) { FactoryGirl.create(:user) }

    describe "for new customer" do
      before { visit new_customer_path(customer) }
      it { should have_title(full_title('Sign-in')) }
      describe "but after user sign in" do
        before { sign_in user } 
        it { should have_title(full_title('New Customer')) }
      end
    end

    describe "for edit customer" do
      before { visit edit_customer_path(customer) }
      it { should have_title(full_title('Sign-in')) }
      describe "but after user sign in" do
        before { sign_in user } 
        it { should have_title(full_title('Edit Customer')) }
      end
    end

  end
end

