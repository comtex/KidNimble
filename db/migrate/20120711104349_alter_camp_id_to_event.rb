class AlterCampIdToEvent < ActiveRecord::Migration
  def up
    rename_column :events, :camp_id, :group_id
    rename_column :events, :price, :location
  end

  def down
  end
end
