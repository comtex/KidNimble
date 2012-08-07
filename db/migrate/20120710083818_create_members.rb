class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :group_id
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :status

      t.timestamps
    end
  end
end
