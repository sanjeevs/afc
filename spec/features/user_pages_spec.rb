require 'spec_helper'

describe "User pages" do
  subject { page }

  describe 'signup page' do
    before { visit signup_path }
    
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_title(full_title('Sign up')) }

    let(:submit) { "Create my account" }
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example user"
        fill_in "Password", with: 'foobar'
        fill_in "Confirmation", with: 'foobar'
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end

  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "invalid user" do
      it { should have_title(full_title('Sign-in')) }
    end

    describe "valid edit user present" do
      before { sign_in user } 
      it { should have_title(full_title('Edit User')) }
      describe "invalid content" do
        before { click_button "Save changes" }
        it { should have_content('error') }
      end
    end
  end

  describe 'profile page' do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_title(full_title(user.name)) }
  end

  describe "index page" do
    before { visit users_path }
    describe "invalid user" do
      it { should have_title(full_title('Sign-in')) }
    end

    describe "valid user present" do
      before do
        sign_in FactoryGirl.create(:user)
        FactoryGirl.create(:user, name: "Bob", password: "foobar")
        FactoryGirl.create(:user, name: "Ben", password: "foobar")
        visit users_path
      end

      it { should have_title(full_title("All Users")) }
      it { should have_selector("h1", text: "All Users") }
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end
  end

end

