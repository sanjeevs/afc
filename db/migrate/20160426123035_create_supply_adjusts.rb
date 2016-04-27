class CreateSupplyAdjusts < ActiveRecord::Migration
  def change
    create_table :supply_adjusts do |t|
      t.integer :amount
      t.references :supply, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
