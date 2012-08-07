class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :buyable_id
      t.string  :buyable_type
      t.integer :kid_id
      t.string :name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :email
      t.string :status
      t.text :response

      t.timestamps
    end
    add_index :orders, :user_id
    add_index :orders, :buyable_id
    add_index :orders, :buyable_type
    add_index :orders, :status
  end
end
