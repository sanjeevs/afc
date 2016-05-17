require 'spec_helper'

describe "Authentication" do

  subject { page }

  # Make sure that signin works.
  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1', text: 'Sign in') }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title(full_title('Sign-in')) }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Name", with: user.name
        fill_in "Password", with: user.password
        click_button 'Sign in'
      end
      it { should have_title(full_title(user.name)) }
      describe "click on home" do
        before do 
          click_link "Home"
        end
        it { should have_title(full_title('Home')) }
        it { should_not have_selector('div.alert.alert-error', 
                                      text: 'Invalid') }
      end
    end

  end

  describe "for non signed in user" do
    let(:user) { FactoryGirl.create(:user) }

    describe "visiting the edit page" do
      before { visit edit_user_path(user) }
      it { should have_title(full_title('Sign-in')) }
    end
  end

  describe "wrong user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:wrong_user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "visiting user#edit page" do
      before { visit edit_user_path(wrong_user) }
      it { should_not have_title(full_title('Edit User')) }
    end

  end    

  describe "for non signed-in users" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit root_path
      fill_in "Name", with: user.name
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    describe "after sign in" do
      it "should render the protected page" do
        page.should have_title(full_title('Home'))
      end
    end
  end

end

