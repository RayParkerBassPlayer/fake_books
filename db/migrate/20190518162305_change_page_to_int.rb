class ChangePageToInt < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :page_int, :integer, :default => 0

    Location.all.each do |l|
      l.page_int = l.page.to_i
      l.save!
    end

    remove_column :locations, :page
    rename_column :locations, :page_int, :page
  end
end
