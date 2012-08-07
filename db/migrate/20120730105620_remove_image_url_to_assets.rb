class RemoveImageUrlToAssets < ActiveRecord::Migration
  def up
    remove_column :assets, :image_url
      end

  def down
    add_column :assets, :image_url, :string
  end
end
