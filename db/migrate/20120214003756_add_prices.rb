class AddPrices < ActiveRecord::Migration
  def change
    add_column :events, :price, :integer, :null => false, :default => 0
    add_column :orders, :total, :integer, :null => false, :default => 0
    execute "update events set price=((rand()*100000)+10000)"
    add_column :users,  :vault_id, :string
  end
end
