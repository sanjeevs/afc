require 'rails_helper'

describe UpdateProductAmount do
  before do
    @production_run = FactoryGirl.create(:production_run)
  end

  context "invalid production run id" do
    it "raise an exception" do
      expect { UpdateProductAmount.new.production_run_update(0, 1) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe "increasing prod run amount" do
    before do
      # First time this production run produced 100.
      # The number of product remaining is 200 (there were other runs).
      # If we change the amount in the production run to 150 then the amount
      # of product would increase by the net ie 50.
      @production_run.amount = 107
      @production_run.product.amount = 213
      @production_run.product.save!
      @production_run.save!
      result = UpdateProductAmount.new.production_run_update(@production_run.id, 150)
      @pr = result.production_run
    end
    it {expect(@pr.amount).to eql(150) } 
    it {expect(@pr.product.amount).to eql(213-107+150) } 
  end

  describe "decreasing prod run amount" do
    before do
      # First time this production run produced 111.
      # The number of product remaining is 213 (there were other runs).
      # If we change the amount in the production run to 13 then the amount
      # of product would decrease by the net.
      @production_run.amount = 111
      @production_run.product.amount = 213
      @production_run.product.save!
      @production_run.save!
      @result = UpdateProductAmount.new.production_run_update(@production_run.id, 13)
      @pr = @result.production_run
    end
    it { expect(@result.success?).to eql(true) }
    it { expect(@pr.amount).to eql(13) } 
    it { expect(@pr.product.amount).to eql(213-111+13) } 
  end

  describe 'invalid prod run amount' do
    before do
      # First time this production run produced 200.
      # The number of product remaining is 1
      # If we change the amount in the production run to 2 then the amount
      # of product would be invalid.
      @production_run.amount = 200 
      @production_run.product.amount = 1 
    end
    it do
      expect {
         UpdateProductAmount.new.production_run_update(@production_run.id, 2)
      }.to raise_exception ActiveRecord::RecordInvalid
    end
    it { expect(@production_run.amount).to eql(200) }
    it { expect(@production_run.product.amount).to eql(1) }
  end
end

