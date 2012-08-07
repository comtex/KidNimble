class AddSourceUrlToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :source_url, :string

  end
end
