class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.date :start
      t.date :end
      t.float :amount
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
