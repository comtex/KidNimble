class AlterResidencyToStreetToMastercampDetails < ActiveRecord::Migration
  def change
    change_table :mastercamp_details do |t|
      t.rename :residency, :street
    end
  end
end
