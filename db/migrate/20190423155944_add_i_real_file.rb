class AddIRealFile < ActiveRecord::Migration[5.2]
  def change
    create_table :i_real_files do |t|
      t.integer :tune_id
      t.string :json_file
      t.timestamps
    end
  end
end
