class ChangeJsonColToJsonOnIReal < ActiveRecord::Migration[5.2]
  def change
    enable_extension "hstore"

    remove_column :i_real_files, :json_file
    add_column :i_real_files, :song_hash, :hstore, :default => {}
  end
end
