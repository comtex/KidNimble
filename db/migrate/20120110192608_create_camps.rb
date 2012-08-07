class CreateCamps < ActiveRecord::Migration
  include Rake::DSL
  def up
    create_table :camps do |t|
      t.column :title,       :string
      t.column :type,        :string
      t.column :description, :text
      t.column :url,         :string
      t.column :phone,       :string
      t.column :fax,         :string
      t.column :address,     :string
      t.column :year_established, :string
      t.column :activities,  :string
      t.column :logo,        :string
      t.column :gender,      :string
      t.column :age_limit,   :string

      t.timestamps
    end

    puts "Importing mysql data..."
    config   = Rails.configuration.database_configuration
    host     = config[Rails.env]["host"]
    database = config[Rails.env]["database"]
    username = config[Rails.env]["username"]
    password = config[Rails.env]["password"]
    sh "mysql -u '#{username}' -h '#{host}' #{database} --password='#{password}' < #{Rails.root.join('data','summercamp_data.sql').to_s}"

    rename_column :camps, :type, :category
    rename_column :camps, :age_limit, :age
    rename_column :camps, :year_established, :started_at
  end

  def down
    drop_table :camps
  end
end
