class CreateProductionRunsSupplies < ActiveRecord::Migration
  def change
    create_table :production_runs_supplies, id: false  do |t|
      t.references :supply, index: true, foreign_key: true
      t.references :production_run, index: true, foreign_key: true
    end
  end
end
