require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1', text: 'Sign in') }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title(full_title('Sign-in')) }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "click on home" do
        before { click_link "Home" }
        it { should have_title(full_title('Home')) }
        it { should_not have_selector('div.alert.alert-error', 
                                      text: 'Invalid') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button 'Sign in'
      end
      it { should have_title(full_title(user.name)) }
    end

  end

end

