class AddConcessionaryToEntero < ActiveRecord::Migration
  def change
    add_reference :enteros, :concessionary, index: true, foreign_key: true
  end
end
