class DelUserFromAdjusts < ActiveRecord::Migration
  def change
    remove_column :product_adjusts, :name
    remove_column :product_adjusts, :email
    remove_column :supply_adjusts, :name
    remove_column :supply_adjusts, :email
  end
end
