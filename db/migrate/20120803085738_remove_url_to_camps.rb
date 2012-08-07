class RemoveUrlToCamps < ActiveRecord::Migration
  def up
    remove_column :camps, :url
      end

  def down
    add_column :camps, :url, :string
  end
end
