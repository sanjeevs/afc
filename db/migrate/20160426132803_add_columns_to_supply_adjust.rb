class AddColumnsToSupplyAdjust < ActiveRecord::Migration
  def change
    add_column :supply_adjusts, :name, :string
    add_column :supply_adjusts, :email, :string
  end
end
