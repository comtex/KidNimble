class CreateOptins < ActiveRecord::Migration
  def change
    create_table :optins do |t|
      t.string :email
    end
  end
end
