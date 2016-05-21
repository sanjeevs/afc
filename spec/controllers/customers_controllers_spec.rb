require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  before do
    cookies[:remember_token] = user.remember_token
  end

  describe "GET #index" do
    it "populates the array of customers" do
      customer = FactoryGirl.create(:customer)
      get :index
      assigns(:customers).should eq([customer])
    end
  end

end
