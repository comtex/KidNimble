class RemoveImageToActivities < ActiveRecord::Migration
  def up
    remove_column :activities, :image
      end

  def down
    add_column :activities, :image, :string
  end
end
