require 'rails_helper'

describe "Compute Product total" do
  before do
    @product = Product.create!(name: 'zukti') 
    @another_product = Product.create!(name: 'piaz') 
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
      @another_product.product_shipments << ProductShipment.new(customer_id: @customer.id, amount: 3)
    end
    it { expect(@customer.product_shipments.size).to eql(4) }
    it { expect(@product.product_shipments.size).to eql(3) }
    it { expect(@another_product.product_shipments.size).to eql(1) }
    it { expect(@product.total_shipments).to eql(6) }
    it { expect(@another_product.total_shipments).to eql(3) }
  end
  
  context "sum total adjusts" do
    before do
      @customer = Customer.create!(name: 'southern season')
      @product.product_adjusts << ProductAdjust.new(amount: -1)
      @product.save!  #Helps to validate all the children.
    end
    it { expect(@product.product_adjusts.size).to eql(1) }
    it { expect(@product.product_adjusts[0].amount).to eql(-1) }
    it { expect(@product.total_adjusts).to eql(-1) }
  end
end
