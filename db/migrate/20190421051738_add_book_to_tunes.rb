class AddBookToTunes < ActiveRecord::Migration[5.2]
  def change
    add_column :tunes, :book_id, :int
  end
end
