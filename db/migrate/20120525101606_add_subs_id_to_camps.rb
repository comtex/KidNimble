class AddSubsIdToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :subs_id, :int

  end
end
