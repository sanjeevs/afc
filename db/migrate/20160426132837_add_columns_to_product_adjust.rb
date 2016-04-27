class AddColumnsToProductAdjust < ActiveRecord::Migration
  def change
    add_column :product_adjusts, :name, :string
    add_column :product_adjusts, :email, :string
  end
end
