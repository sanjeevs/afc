require 'rails_helper'

describe "Compute Product total" do
  before do
    @product = Product.create!(name: 'zukti') 
    @producer = Producer.create!(name: 'bobbees')
    @product.production_runs << ProductionRun.new(producer_id: @producer.id, amount: 100)
    @product.production_runs << ProductionRun.new(producer_id: @producer.id, amount: 200)
  end

  subject { @product}

  context "sum total production" do
    it { expect(@product.production_runs.size()).to eql(2) }
    it { expect(@product.total_production_amount).to eql(300) }
  end

  context "sum total shipments" do
    before do
      @customer = Customer.create!(name: 'southern season')
      @product.product_shipments << ProductShipment.new(customer_id: @customer.id, amount: 1)
      @product.product_shipments << ProductShipment.new(customer_id: @customer.id, amount: 2)
      @product.product_shipments << ProductShipment.new(customer_id: @customer.id, amount: 3)
      ProductShipment.new(customer_id: @customer.id, amount: 3)
    end
    it { expect(@customer.product_shipments.size).to eql(3) }
    it { expect(@product.total_shipments).to eql(6) }
  end
end
