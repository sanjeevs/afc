require 'rails_helper'

RSpec.describe ProducersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  before do
    cookies[:remember_token] = user.remember_token
  end

  describe "GET #index" do
    it "populates the array of producers" do
      producer = FactoryGirl.create(:producer)
      get :index
      assigns(:producers).should eq([producer])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested producer to @producer" do
      producer = FactoryGirl.create(:producer)
      get :show, id: producer
      assigns(:producer).should eq(producer)
    end

    it "renders the :show view" do
      get :show, id: FactoryGirl.create(:producer)
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
      it "created a new producer" do
        expect {
          post :create, producer: FactoryGirl.attributes_for(:producer)
        }.to change(Producer, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact" do
        expect {
          post :create, producer: FactoryGirl.attributes_for(:invalid_producer)
        }.to_not change(Producer, :count)
      end

      it "re renders the new method" do
          post :create, producer: FactoryGirl.attributes_for(:invalid_producer)
          response.should render_template :new
      end
    end
  end

  describe "PUT Update" do
    before :each do
      @producer = FactoryGirl.create(:producer, name: "Larry")
    end
    
    context "valid attributes" do
      it "located the requested @producer" do
        put :update, id: @producer, producer: FactoryGirl.attributes_for(:producer)
        assigns(:producer).should eq(@producer)
      end

      it "changes @producer attributes" do 
        put :update, id: @producer, producer: FactoryGirl.attributes_for(:producer, name: 'Sanjeev')
        @producer.reload
        @producer.name.should eq('Sanjeev')
      end

      it "redirects to the updated page" do
        put :update, id: @producer, producer: FactoryGirl.attributes_for(:producer)
        response.should redirect_to @producer
      end
    end

    context "invalid attributes" do
      it "locates the requested producer" do
        put :update, id: @producer, producer: FactoryGirl.attributes_for(:invalid_producer) 
        assigns(:producer).should eq(@producer)
      end

      it "re-renders the edit method" do
        put :update, id: @producer, producer: FactoryGirl.attributes_for(:invalid_producer) 
        response.should render_template :edit
      end

    end
  end

  describe "DELETE destroy" do
    before :each do
      @producer = FactoryGirl.create(:producer)
    end

    it "deletes the contact" do
      expect {
        delete :destroy, id: @producer
      }.to change(Producer, :count).by(-1)
    end

    it "redirects to producers#index" do
      delete :destroy, id: @producer
      response.should redirect_to producers_url
    end
  end

end
