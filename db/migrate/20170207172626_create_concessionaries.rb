class CreateConcessionaries < ActiveRecord::Migration
  def change
    create_table :concessionaries do |t|
      t.string :name
      t.string :telephone

      t.timestamps null: false
    end
  end
end
