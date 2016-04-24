class AddIndexToSuppliersName < ActiveRecord::Migration
  def change
    add_index :suppliers, :name, unique: true
  end
end
