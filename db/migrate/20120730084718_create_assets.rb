class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :camp
      t.references :mastercamp_detail
      t.has_attached_file :asset
    
      t.timestamps
    end
  end
end
