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

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested customer to @customer" do
      customer = FactoryGirl.create(:customer)
      get :show, id: customer
      assigns(:customer).should eq(customer)
    end

    it "renders the :show view" do
      get :show, id: FactoryGirl.create(:customer)
      response.should render_template :show
    end
  end

  describe "Get #new" do
    it "renders the new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "created a new customer" do
        expect {
          post :create, customer: FactoryGirl.attributes_for(:customer)
        }.to change(Customer, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact" do
        expect {
          post :create, customer: FactoryGirl.attributes_for(:invalid_customer)
        }.to_not change(Customer, :count)
      end

      it "re renders the new method" do
          post :create, customer: FactoryGirl.attributes_for(:invalid_customer)
          response.should render_template :new
      end
    end
  end

  describe "PUT Update" do
    before :each do
      @customer = FactoryGirl.create(:customer, name: "Larry")
    end
    
    context "valid attributes" do
      it "located the requested @customer" do
        put :update, id: @customer, customer: FactoryGirl.attributes_for(:customer)
        assigns(:customer).should eq(@customer)
      end

      it "changes @customer attributes" do 
        put :update, id: @customer, customer: FactoryGirl.attributes_for(:customer, name: 'Sanjeev')
        @customer.reload
        @customer.name.should eq('Sanjeev')
      end

      it "redirects to the updated page" do
        put :update, id: @customer, customer: FactoryGirl.attributes_for(:customer)
        response.should redirect_to @customer
      end
    end

    context "invalid attributes" do
      it "locates the requested customer" do
        put :update, id: @customer, customer: FactoryGirl.attributes_for(:invalid_customer) 
        assigns(:customer).should eq(@customer)
      end

      it "re-renders the edit method" do
        put :update, id: @customer, customer: FactoryGirl.attributes_for(:invalid_customer) 
        response.should render_template :edit
      end

    end
  end

  describe "DELETE destroy" do
    before :each do
      @customer = FactoryGirl.create(:customer)
    end

    it "deletes the contact" do
      expect {
        delete :destroy, id: @customer
      }.to change(Customer, :count).by(-1)
    end

    it "redirects to customers#index" do
      delete :destroy, id: @customer
      response.should redirect_to customers_url
    end
  end

end
