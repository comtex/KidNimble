class CreateMastercampDetails < ActiveRecord::Migration
  def change
    create_table :mastercamp_details do |t|
      t.references :mastercamp, :default => 0
      t.string :camp_name
      t.string :city
      t.string :state
      t.string :zip
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.references :category, :default => 0
      t.references :subs, :default => 0
      t.string :youngest
      t.string :oldest
      t.datetime :datetime_start
      t.datetime :datetime_end
      t.string :residency
      t.text :description
      t.integer :rating
      t.integer :raters

      t.timestamps
    end
  end
end
