class CreateMastercamps < ActiveRecord::Migration
  def change
    create_table :mastercamps do |t|
      t.string :contact
      t.string :phone
      t.string :fax
      t.string :email
      t.string :website

      t.timestamps
    end
  end
end
