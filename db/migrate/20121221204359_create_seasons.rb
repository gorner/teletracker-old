class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :series_id, :null => false
      t.integer :number, :null => false, :default => 1

      t.timestamps
    end
  end
end
