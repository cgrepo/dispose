class ChangeQuantityToFloatEnteros < ActiveRecord::Migration
  def change
    change_column(:enteros, :quantity, :float)
  end
end
