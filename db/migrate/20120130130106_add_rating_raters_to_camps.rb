class AddRatingRatersToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :rating, :integer
    add_column :camps, :raters, :integer
  end
end
