class CreateCounselors < ActiveRecord::Migration
  def change
    create_table :counselors do |t|
      t.integer  :user_id
      t.integer  :camp_id
      t.string   :approved, :default => 'N'

      t.timestamps
    end
    add_index :counselors, :approved
  end
end
