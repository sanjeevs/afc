require 'spec_helper'

describe "Customer pages" do
  subject { page }

  describe "edit" do
    let(:customer) { FactoryGirl.create(:customer) }
    before { visit edit_customer_path(customer) }

    describe "invalid user" do
      it { should have_title(full_title('Sign-in')) }
    end

    describe "with valid user present" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user } 
      it { should have_title(full_title('Edit Customer')) }
      describe "invalid content" do
        before { click_button "Save changes" }
        it { should have_content('Customer details updated') }
      end
    end
  end
end

