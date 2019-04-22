class CreateQueryLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :query_logs do |t|
      t.string :ip
      t.string :query

      t.datetime :created_at, :null => false    
    end
  end
end
