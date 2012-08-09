# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120809133109) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activities", :force => true do |t|
    t.integer  "camp_id"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "assets", :force => true do |t|
    t.integer  "camp_id"
    t.integer  "mastercamp_detail_id"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "bookmarks", :force => true do |t|
    t.integer  "camp_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "camps", :force => true do |t|
    t.string   "title"
    t.string   "camp_format"
    t.string   "location"
    t.string   "camp_length"
    t.text     "description"
    t.string   "cost_per_week"
    t.text     "general_information"
    t.string   "contact_name"
    t.string   "contact_title"
    t.string   "email"
    t.string   "phone"
    t.string   "phone2"
    t.string   "fax"
    t.string   "address"
    t.string   "started_at"
    t.string   "activities"
    t.string   "logo"
    t.string   "gender"
    t.string   "age"
    t.string   "youngest_age_admitted"
    t.string   "oldest_age_admitted"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "longitude",             :precision => 15, :scale => 10
    t.decimal  "latitude",              :precision => 15, :scale => 10
    t.string   "country"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "category_id"
    t.string   "capacity"
    t.string   "religious_affilation"
    t.string   "cost_per_day"
    t.string   "director"
    t.string   "contact_email"
    t.string   "owner"
    t.string   "map_url"
    t.integer  "rating"
    t.integer  "raters"
    t.string   "subs_id"
  end

  add_index "camps", ["latitude"], :name => "index_camps_on_latitude"
  add_index "camps", ["longitude"], :name => "index_camps_on_longitude"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", :force => true do |t|
    t.integer  "camp_id"
    t.integer  "subs_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counselors", :force => true do |t|
    t.integer  "user_id"
    t.integer  "camp_id"
    t.string   "approved",   :default => "N"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "counselors", ["approved"], :name => "index_counselors_on_approved"

  create_table "deals", :force => true do |t|
    t.integer  "camp_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "deals", ["camp_id"], :name => "index_deals_on_camp_id"

  create_table "directorforms", :force => true do |t|
    t.string   "session_title"
    t.string   "session_title2"
    t.string   "session_title3"
    t.string   "session_title4"
    t.string   "session_title5"
    t.string   "session_title6"
    t.string   "subcategory"
    t.string   "subcategory2"
    t.string   "subcategory3"
    t.string   "subcategory4"
    t.string   "subcategory5"
    t.string   "subcategory6"
    t.string   "residency"
    t.string   "residency2"
    t.string   "residency3"
    t.string   "residency4"
    t.string   "residency5"
    t.string   "residency6"
    t.date     "date_start"
    t.date     "date_start2"
    t.date     "date_start3"
    t.date     "date_start4"
    t.date     "date_start5"
    t.date     "date_start6"
    t.date     "date_end"
    t.date     "date_end2"
    t.date     "date_end3"
    t.date     "date_end4"
    t.date     "date_end5"
    t.date     "date_end6"
    t.time     "time_start"
    t.time     "time_start2"
    t.time     "time_start3"
    t.time     "time_start4"
    t.time     "time_start5"
    t.time     "time_start6"
    t.time     "time_end"
    t.time     "time_end2"
    t.time     "time_end3"
    t.time     "time_end4"
    t.time     "time_end5"
    t.time     "time_end6"
    t.integer  "youngest"
    t.integer  "youngest2"
    t.integer  "youngest3"
    t.integer  "youngest4"
    t.integer  "youngest5"
    t.integer  "youngest6"
    t.integer  "oldest"
    t.integer  "oldest2"
    t.integer  "oldest3"
    t.integer  "oldest4"
    t.integer  "oldest5"
    t.integer  "oldest6"
    t.string   "location_address"
    t.string   "location_address2"
    t.string   "location_address3"
    t.string   "location_address4"
    t.string   "location_address5"
    t.string   "location_address6"
    t.text     "session_description"
    t.text     "session_description2"
    t.text     "session_description3"
    t.text     "session_description4"
    t.text     "session_description5"
    t.text     "session_description6"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "event_series", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "frequency"
    t.datetime "starttime"
    t.datetime "endtime"
    t.integer  "all_day",    :limit => 1
    t.string   "period",                  :default => "months"
    t.integer  "endtil",                  :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "event_series_id"
    t.datetime "starttime"
    t.datetime "endtime"
    t.integer  "all_day",         :limit => 1
    t.string   "title"
    t.string   "description"
    t.integer  "endtil",                       :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "groups", ["user_id"], :name => "index_groups_on_user_id"

  create_table "incoming_mails", :force => true do |t|
    t.integer  "from_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "kids", :force => true do |t|
    t.integer  "user_id",                 :null => false
    t.string   "name",                    :null => false
    t.string   "sex",        :limit => 0, :null => false
    t.date     "born_at",                 :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "kids", ["user_id"], :name => "index_kids_on_user_id"

  create_table "mastercamp_details", :force => true do |t|
    t.integer  "mastercamp_id",                                  :default => 0
    t.string   "camp_name"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.decimal  "latitude",       :precision => 15, :scale => 10
    t.decimal  "longitude",      :precision => 15, :scale => 10
    t.integer  "category_id",                                    :default => 0
    t.integer  "subs_id",                                        :default => 0
    t.string   "youngest"
    t.string   "oldest"
    t.datetime "datetime_start"
    t.datetime "datetime_end"
    t.string   "street"
    t.text     "description"
    t.integer  "rating"
    t.integer  "raters"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
  end

  create_table "mastercamps", :force => true do |t|
    t.string   "contact"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "website"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "members", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "optins", :force => true do |t|
    t.string "email"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "buyable_id"
    t.string   "buyable_type"
    t.integer  "kid_id"
    t.string   "name"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "status"
    t.text     "response"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "total",        :default => 0, :null => false
  end

  add_index "orders", ["buyable_id"], :name => "index_orders_on_buyable_id"
  add_index "orders", ["buyable_type"], :name => "index_orders_on_buyable_type"
  add_index "orders", ["status"], :name => "index_orders_on_status"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "camp_id"
    t.integer  "rating"
    t.string   "title"
    t.text     "note"
    t.string   "url"
    t.string   "source_url"
    t.string   "approved",   :default => "Y"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "reviews", ["approved"], :name => "index_reviews_on_approved"
  add_index "reviews", ["camp_id"], :name => "index_reviews_on_camp_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "subs", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.string   "email"
    t.text     "like"
    t.text     "improve"
    t.integer  "rating"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "camp_id"
    t.string   "camp"
  end

  create_table "temp_reviews", :force => true do |t|
    t.integer  "camp_id",    :null => false
    t.integer  "rating",     :null => false
    t.text     "note",       :null => false
    t.string   "url",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.boolean  "success"
    t.text     "message"
    t.string   "authorization"
    t.text     "response"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "transactions", ["order_id"], :name => "index_transactions_on_order_id"
  add_index "transactions", ["user_id"], :name => "index_transactions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "camp_id"
    t.integer  "level"
    t.string   "company"
    t.string   "title"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "vault_id"
    t.string   "first_name",                            :default => "", :null => false
    t.string   "last_name",                             :default => "", :null => false
    t.string   "country"
    t.string   "card_type"
    t.string   "card_shem"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wishes", :force => true do |t|
    t.integer  "buyable_id"
    t.string   "buyable_type"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "wishes", ["buyable_id"], :name => "index_wishes_on_buyable_id"
  add_index "wishes", ["buyable_type"], :name => "index_wishes_on_buyable_type"
  add_index "wishes", ["user_id"], :name => "index_wishes_on_user_id"

  create_table "zips", :force => true do |t|
    t.string   "zip",                                        :null => false
    t.string   "city"
    t.string   "county"
    t.string   "state"
    t.string   "country"
    t.decimal  "latitude",   :precision => 15, :scale => 10
    t.decimal  "longitude",  :precision => 15, :scale => 10
    t.string   "metaphone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
