class CreateIncomingMails < ActiveRecord::Migration
  def change
    create_table :incoming_mails do |t|
      t.integer :from_id
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
