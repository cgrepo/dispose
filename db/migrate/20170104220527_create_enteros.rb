class CreateEnteros < ActiveRecord::Migration
  def change
    create_table :enteros do |t|
      t.string :taxpayer
      t.string :service
      t.string :unit
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
