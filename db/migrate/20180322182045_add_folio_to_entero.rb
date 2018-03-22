class AddFolioToEntero < ActiveRecord::Migration
  def change
    add_column :enteros, :folio, :string
  end
end
