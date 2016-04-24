class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :amount
      t.text :comment

      t.timestamps null: false
    end
  end
end
