class CreateProductShipments < ActiveRecord::Migration
  def change
    create_table :product_shipments do |t|
      t.integer :amount
      t.references :product, index: true, foreign_key: true
      t.date :ship_date
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
