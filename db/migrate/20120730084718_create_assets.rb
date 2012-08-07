class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :camp_id
      t.string :image_url

      t.timestamps
    end
  end
end
