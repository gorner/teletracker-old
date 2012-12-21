class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :title, :null => false
      t.text :description
      t.integer :category_id
      t.float :rating

      t.timestamps
    end
  end
end
