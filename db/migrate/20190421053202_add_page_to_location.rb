class AddPageToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :page, :string
  end
end
