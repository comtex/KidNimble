class AddNameAndAddress < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name,  :string
    rename_column :users, :address, :address1
    add_column :users, :country,    :string
    add_column :users, :card_type,  :string
    add_column :users, :card_shem,  :string
    remove_column :users, :name
  end
end
