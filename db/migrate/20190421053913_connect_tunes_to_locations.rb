class ConnectTunesToLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :tunes, :book_id
  end
end
