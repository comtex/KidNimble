class RenameCols < ActiveRecord::Migration
  def change
    rename_column :categorizations, :sub_id, :subs_id
  end
end
