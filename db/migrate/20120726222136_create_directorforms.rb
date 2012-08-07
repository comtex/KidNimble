class CreateDirectorforms < ActiveRecord::Migration
  def change
    create_table :directorforms do |t|
      t.string :session_title
      t.string :session_title2
      t.string :session_title3
      t.string :session_title4
      t.string :session_title5
      t.string :session_title6
      t.string :subcategory
      t.string :subcategory2
      t.string :subcategory3
      t.string :subcategory4
      t.string :subcategory5
      t.string :subcategory6
      t.string :residency
      t.string :residency2
      t.string :residency3
      t.string :residency4
      t.string :residency5
      t.string :residency6
      t.date :date_start
      t.date :date_start2
      t.date :date_start3
      t.date :date_start4
      t.date :date_start5
      t.date :date_start6
      t.date :date_end
      t.date :date_end2
      t.date :date_end3
      t.date :date_end4
      t.date :date_end5
      t.date :date_end6
      t.time :time_start
      t.time :time_start2
      t.time :time_start3
      t.time :time_start4
      t.time :time_start5
      t.time :time_start6
      t.time :time_end
      t.time :time_end2
      t.time :time_end3
      t.time :time_end4
      t.time :time_end5
      t.time :time_end6
      t.integer :youngest
      t.integer :youngest2
      t.integer :youngest3
      t.integer :youngest4
      t.integer :youngest5
      t.integer :youngest6
      t.integer :oldest
      t.integer :oldest2
      t.integer :oldest3
      t.integer :oldest4
      t.integer :oldest5
      t.integer :oldest6
      t.string :location_address
      t.string :location_address2
      t.string :location_address3
      t.string :location_address4
      t.string :location_address5
      t.string :location_address6
      t.text :session_description
      t.text :session_description2
      t.text :session_description3
      t.text :session_description4
      t.text :session_description5
      t.text :session_description6

      t.timestamps
    end
  end
end
