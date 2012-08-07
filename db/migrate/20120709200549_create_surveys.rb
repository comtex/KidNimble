class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :email
      t.text :like
      t.text :improve
      t.integer :rating

      t.timestamps
    end
  end
end
