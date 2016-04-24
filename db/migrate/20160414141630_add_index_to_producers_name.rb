class AddIndexToProducersName < ActiveRecord::Migration
  def change
    add_index :producers, :name, unique: true
  end
end
