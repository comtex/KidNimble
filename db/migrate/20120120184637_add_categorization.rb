class AddCategorization < ActiveRecord::Migration
  def change
    rename_table :camps_subs, :categorizations
  end
end
