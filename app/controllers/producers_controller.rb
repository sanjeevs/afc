# Controller for producers

class ProducersController < ApplicationController
  before_action :signed_in_user, 

  def new
    @producer = Producer.new
  end

  def create
    @producer = Producer.new(producer_params)
    if @producer.save
      flash[:success] = "producer created"
      redirect_to @producer
    else
      render 'new'
    end
  end

  def index
    @producers = Producer.paginate(page: params[:page])
  end

  def show
    @producer = Producer.find(params[:id])
  end

  def edit
    @producer = Producer.find(params[:id])
  end

  def update
    @producer = Producer.find(params[:id]) 
    if @producer.update_attributes(producer_params)
      flash[:success] = "producer details updated"
      redirect_to @producer
    else
      render 'edit' 
    end
  end

  def destroy
    Producer.find(params[:id]).destroy
    flash[:success] = "producer destroyed"
    redirect_to producers_url
  end

  private
    def producer_params
      params.require(:producer).permit(:name, :address, :city,
                              :state, :zipcode, :phone, :email,
                              :contact)
    end
end
