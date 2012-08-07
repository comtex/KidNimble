class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :order_id
      t.boolean :success
      t.text :message
      t.string :authorization
      t.text :response

      t.timestamps
    end
    add_index :transactions, :user_id
    add_index :transactions, :order_id
  end
end
