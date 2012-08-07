class RemoveImageToCategories < ActiveRecord::Migration
  def up
    remove_column :categories, :image
      end

  def down
    add_column :categories, :image, :string
  end
end
