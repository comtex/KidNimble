class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :camp_id
      t.string :kind
      t.timestamps
    end
  end
end
