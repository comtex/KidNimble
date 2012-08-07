class AddLatLonToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :longitude, :decimal, :precision => 15, :scale => 10
    add_column :camps, :latitude , :decimal, :precision => 15, :scale => 10
    add_index  :camps, :longitude
    add_index  :camps, :latitude
  end
end
