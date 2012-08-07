class AddCityStateZip < ActiveRecord::Migration
  def change
    add_column :camps, :city, :string
    add_column :camps, :state, :string
    add_column :camps, :zip, :string
  end
end
