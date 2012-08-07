class CreateZips < ActiveRecord::Migration
  def change
    create_table :zips do |t|
      t.string  :zip, :null => false
      t.string  :city
      t.string  :county
      t.string  :state
      t.string  :country
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.string  :metaphone

      t.timestamps
    end
  end
end
