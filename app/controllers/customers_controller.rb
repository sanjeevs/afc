# Controller for customers
class CustomersController < ApplicationController
  before_action :signed_in_user, 

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:success] = "Customer created"
      redirect_to @customer
    else
      render 'new'
    end
  end

  def index
    @customers = Customer.paginate(page: params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id]) 
    if @customer.update_attributes(customer_params)
      flash[:success] = "Customer details updated"
      redirect_to @customer
    else
      render 'edit' 
    end
  end

  def destroy
    Customer.find(params[:id]).destroy
    flash[:success] = "Customer destroyed"
    redirect_to customers_url
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :address, :city,
                              :state, :zipcode, :phone, :email)
    end
end
