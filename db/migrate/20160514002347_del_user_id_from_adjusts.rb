class DelUserIdFromAdjusts < ActiveRecord::Migration
  def change
    remove_index :supply_adjusts, :user_id
    remove_column :supply_adjusts, :user_id
    remove_index :product_adjusts, :user_id
    remove_column :product_adjusts, :user_id
  end
end
