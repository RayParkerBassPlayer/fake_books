class CaseInsensitizeFields < ActiveRecord::Migration[5.2]
  def change
    enable_extension :citext

    change_column :tunes, :title, :citext
    remove_index :tunes, :title
    add_index :tunes, :title, unique: true

    change_column :books, :title, :citext
    remove_index :books, :title
    add_index :books, :title, unique: true
  end
end
