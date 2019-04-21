class AddTitleToTunes < ActiveRecord::Migration[5.2]
  def change
    add_column :tunes, :title, :string

    add_index :tunes, :title
  end
end
