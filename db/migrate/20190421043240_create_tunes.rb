class CreateTunes < ActiveRecord::Migration[5.2]
  def change
    create_table :tunes do |t|

      t.timestamps
    end
  end
end
