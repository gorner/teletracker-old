class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.integer :season_id, :null => false
      t.integer :number
      t.string :title
      t.text :description
      t.float :rating

      t.timestamps
    end
  end
end
