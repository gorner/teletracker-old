class AddSidToSeries < ActiveRecord::Migration
  def change
    add_column :series, :sid, :integer
  end
end
