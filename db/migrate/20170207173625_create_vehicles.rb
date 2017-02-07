class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :plate
      t.references :concessionary, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
