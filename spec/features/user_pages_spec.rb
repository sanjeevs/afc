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

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }
      before do
        sign_in FactoryGirl.create(:user)
        visit users_path
      end

      it { should have_title(full_title("All Users")) }
      it { should have_selector("h1", text: "All Users") }
      it { should have_selector("div.pagination") }
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }

        before do
          FactoryGirl.create(:user) 
          sign_in admin
          visit users_path
        end

        it { should have_link('Admin', href: user_path(admin)) }
        #it { should have_link('delete', href: user_path(User.first)) }
        #it { should have_link('foobar', href: 'hello_world' }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

end

