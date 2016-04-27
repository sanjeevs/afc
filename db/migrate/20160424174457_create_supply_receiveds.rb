class CreateSupplyReceiveds < ActiveRecord::Migration
  def change
    create_table :supply_receiveds do |t|
      t.integer :amount
      t.string :unit
      t.references :supply, index: true, foreign_key: true
      t.references :supplier, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
