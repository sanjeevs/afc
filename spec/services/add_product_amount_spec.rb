require 'rails_helper'

describe AddProductAmount do
  before do
    @production_run = FactoryGirl.create(:production_run)
  end

  context "invalid production run id" do
    it "raise an exception" do
      expect { AddProductAmount.new.production_run(0, 1) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe "increasing prod run amount" do
    before do
      # First time this production run produced 100.
      # The number of product remaining is 200 (there were other runs).
      # If we change the amount in the production run to 150 then the amount
      # of product would increase by the net ie 50.
      @production_run.amount = 100
      @production_run.product.amount = 200
      @production_run.product.save!
      @production_run.save!
      @pr = AddProductAmount.new.production_run(@production_run.id, 150)
    end
    it {expect(@pr.amount).to eql(150) } 
    it {expect(@pr.product.amount).to eql(250) } 
  end

  describe "decreasing prod run amount" do
    before do
      # First time this production run produced 100.
      # The number of product remaining is 200 (there were other runs).
      # If we change the amount in the production run to 1 then the amount
      # of product would decrease by the net ie 50.
      @production_run.amount = 100
      @production_run.product.amount = 200
      @production_run.product.save!
      @production_run.save!
      @pr = AddProductAmount.new.production_run(@production_run.id, 1)
    end
    it { expect(@pr.success?).to eql(true) }
  end
end

