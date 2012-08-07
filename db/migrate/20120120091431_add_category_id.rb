class AddCategoryId < ActiveRecord::Migration
  def change
    add_column :camps, :category_id, :integer
    remove_column :categories, :parent_id
    create_table :subs do |t|
      t.integer    :category_id
      t.string     :name
      t.timestamps
    end
    create_table :camps_subs do |t|
      t.integer    :camp_id
      t.integer    :sub_id
      t.timestamps
    end
  end
end
