# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101028064513) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "show_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_reg_requires", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "sys_reg_info_id"
    t.boolean  "required"
  end

  create_table "events", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "intro"
    t.text     "content"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "address"
    t.string   "zipcode"
    t.string   "telnumber"
    t.string   "contact_user_name"
    t.string   "email"
    t.string   "web_url"
    t.integer  "user_id"
    t.string   "event_logo_url"
    t.string   "status"
    t.integer  "category_id"
    t.text     "hostinfo"
    t.integer  "views"
    t.integer  "score"
    t.decimal  "price"
    t.boolean  "each_need_reginfo"
    t.integer  "sold_tickets"
    t.integer  "total_tickets"
  end

  create_table "sys_reg_infos", :force => true do |t|
    t.string   "info_name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_order_details", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_order_id"
    t.integer  "ticket_order_small_id"
    t.integer  "event_reg_require_id"
    t.string   "reg_info_value"
  end

  create_table "ticket_orders", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "ticket_counts"
  end

  create_table "user_fav_events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_fav_events", ["event_id"], :name => "index_user_fav_events_on_event_id"
  add_index "user_fav_events", ["user_id"], :name => "index_user_fav_events_on_user_id"

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                            :null => false
    t.string   "truename"
    t.string   "telnumber"
    t.string   "mobilenumber"
    t.string   "email"
    t.string   "idcode"
    t.boolean  "admin"
    t.string   "crypted_password",                 :null => false
    t.string   "password_salt",                    :null => false
    t.string   "persistence_token",                :null => false
    t.integer  "login_count",       :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
