class RemoveUserIdFromAdjusts < ActiveRecord::Migration
  def change
    remove_foreign_key :supply_adjusts, :users
    remove_foreign_key :product_adjusts, :users
  end
end
