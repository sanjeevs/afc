class CreateProductionRuns < ActiveRecord::Migration
  def change
    create_table :production_runs do |t|
      t.references :producer, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.integer :amount
      t.date :mfgd_date
      t.date :expiry_date
      t.string :lot_id

      t.timestamps null: false
    end
  end
end
