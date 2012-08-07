class AddCampToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :camp, :string

  end
end
