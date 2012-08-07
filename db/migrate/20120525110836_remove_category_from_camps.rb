class RemoveCategoryFromCamps < ActiveRecord::Migration
  def up
    remove_column :camps, :category
      end

  def down
    add_column :camps, :category, :string
  end
end
