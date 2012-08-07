class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.integer :buyable_id
      t.string :buyable_type
      t.integer :user_id

      t.timestamps
    end
    add_index :wishes, :buyable_id
    add_index :wishes, :buyable_type
    add_index :wishes, :user_id
  end
end
