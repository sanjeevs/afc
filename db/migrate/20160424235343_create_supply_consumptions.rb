class CreateSupplyConsumptions < ActiveRecord::Migration
  def change
    create_table :supply_consumptions do |t|
      t.integer :amount
      t.references :supply, index: true, foreign_key: true
      t.references :production_run, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
