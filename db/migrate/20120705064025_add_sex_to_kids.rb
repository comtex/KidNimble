class AddSexToKids < ActiveRecord::Migration
  def change
    add_column :kids, :sex, :int

  end
end
