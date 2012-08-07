class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :camp_id
      t.string :title
      t.text :description

      t.timestamps
    end
    add_index :deals, :camp_id
  end
end
