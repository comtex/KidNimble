class AddCampIdToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :camp_id, :integer

  end
end
