class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer  :camp_id
      t.datetime :start_at
      t.datetime :end_at
      t.string   :name
      t.string   :ages
      t.string   :gender

      t.timestamps
    end
  end
end
