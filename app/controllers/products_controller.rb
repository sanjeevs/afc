# Controller for products

class ProductsController < ApplicationController
  before_action :signed_in_user, 

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "product created"
      redirect_to @product
    else
      render 'new'
    end
  end

  def index
    @products = Product.paginate(page: params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id]) 
    if @product.update_attributes(product_params)
      flash[:success] = "product details updated"
      redirect_to @product
    else
      render 'edit' 
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "product destroyed"
    redirect_to products_url
  end

  private
    def product_params
      params.require(:product).permit(:name, :amount, :comment)
    end
end
