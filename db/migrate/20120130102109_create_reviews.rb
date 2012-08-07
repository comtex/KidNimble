class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :camp_id
      t.integer :rating
      t.string  :title
      t.text    :note
      t.string  :approved, :default => 'N'
      t.timestamps
    end
    add_index :reviews, :user_id
    add_index :reviews, :camp_id
    add_index :reviews, :approved
  end
end
