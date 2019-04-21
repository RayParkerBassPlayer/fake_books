class AddFieldsToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :tune_id, :int
    add_column :locations, :book_id, :int

    add_index :locations, [:tune_id, :book_id]
  end
end
