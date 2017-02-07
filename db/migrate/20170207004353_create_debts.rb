class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.string :range
      t.boolean :payed
      t.references :concessionary, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
