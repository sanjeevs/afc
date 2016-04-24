class CreateProductAdjusts < ActiveRecord::Migration
  def change
    create_table :product_adjusts do |t|
      t.integer :amount
      t.references :product, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
