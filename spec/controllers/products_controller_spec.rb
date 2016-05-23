require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  before do
    cookies[:remember_token] = user.remember_token
  end

  describe "GET #index" do
    it "populates the array of products" do
      product = FactoryGirl.create(:product)
      get :index
      assigns(:products).should eq([product])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested product to @product" do
      product = FactoryGirl.create(:product)
      get :show, id: product
      assigns(:product).should eq(product)
    end

    it "renders the :show view" do
      get :show, id: FactoryGirl.create(:product)
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
      it "created a new product" do
        expect {
          post :create, product: FactoryGirl.attributes_for(:product)
        }.to change(Product, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact" do
        expect {
          post :create, product: FactoryGirl.attributes_for(:invalid_product)
        }.to_not change(Product, :count)
      end

      it "re renders the new method" do
          post :create, product: FactoryGirl.attributes_for(:invalid_product)
          response.should render_template :new
      end
    end
  end

  describe "PUT Update" do
    before :each do
      @product = FactoryGirl.create(:product, name: "Larry")
    end
    
    context "valid attributes" do
      it "located the requested @product" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product)
        assigns(:product).should eq(@product)
      end

      it "changes @product attributes" do 
        put :update, id: @product, product: FactoryGirl.attributes_for(:product, name: 'Sanjeev')
        @product.reload
        @product.name.should eq('Sanjeev')
      end

      it "redirects to the updated page" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product)
        response.should redirect_to @product
      end
    end

    context "invalid attributes" do
      it "locates the requested product" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:invalid_product) 
        assigns(:product).should eq(@product)
      end

      it "re-renders the edit method" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:invalid_product) 
        response.should render_template :edit
      end

    end
  end

  describe "DELETE destroy" do
    before :each do
      @product = FactoryGirl.create(:product)
    end

    it "deletes the contact" do
      expect {
        delete :destroy, id: @product
      }.to change(Product, :count).by(-1)
    end

    it "redirects to products#index" do
      delete :destroy, id: @product
      response.should redirect_to products_url
    end
  end

end
