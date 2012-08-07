class CreateKids < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.integer :user_id
      t.string  :name
      t.date    :born_at

      t.timestamps
    end
    add_index :kids, :user_id
  end
end
