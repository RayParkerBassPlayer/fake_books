class AddOffsetToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :offset, :integer, :default => 0

    Book.update_all(:offset => 0)
  end
end
