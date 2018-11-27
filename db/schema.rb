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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181113063950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "expires_at"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "api_keys", ["access_token"], name: "idx_108545_index_api_keys_on_access_token", unique: true, using: :btree
  add_index "api_keys", ["access_token"], name: "index_api_keys_on_access_token", unique: true, using: :btree
  add_index "api_keys", ["user_id"], name: "idx_108545_index_api_keys_on_user_id", using: :btree
  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id", using: :btree

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "expires_at"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "api_keys", ["access_token"], name: "idx_108545_index_api_keys_on_access_token", unique: true, using: :btree
  add_index "api_keys", ["access_token"], name: "index_api_keys_on_access_token", unique: true, using: :btree
  add_index "api_keys", ["user_id"], name: "idx_108545_index_api_keys_on_user_id", using: :btree
  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id", using: :btree

  create_table "bar_codes", force: :cascade do |t|
    t.string   "asn"
    t.string   "part_code"
    t.integer  "qty"
    t.date     "date"
    t.integer  "lot_size"
    t.integer  "target"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "charts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "charts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee_productivities", force: :cascade do |t|
    t.integer  "device_id"
    t.string   "device_active"
    t.string   "axis_data"
    t.string   "emp_activity"
    t.string   "idle"
    t.string   "pick"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "iot_data", force: :cascade do |t|
    t.integer  "workbench_number"
    t.string   "part_number"
    t.integer  "target"
    t.integer  "lot_size"
    t.string   "employee_name"
    t.integer  "employee_id"
    t.string   "shift"
    t.integer  "device_id"
    t.integer  "count"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "status"
  end

  create_table "iot_data", force: :cascade do |t|
    t.integer  "workbench_number"
    t.string   "part_number"
    t.integer  "target"
    t.integer  "lot_size"
    t.string   "employee_name"
    t.integer  "employee_id"
    t.string   "shift"
    t.integer  "device_id"
    t.integer  "count"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "status"
  end

  create_table "measures", force: :cascade do |t|
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sensor_id"
  end

  create_table "measures", force: :cascade do |t|
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sensor_id"
  end

  create_table "part_masters", force: :cascade do |t|
    t.string   "part_code"
    t.string   "part_description"
    t.string   "IDE_type"
    t.decimal  "no_of_units_per_IDE"
    t.decimal  "UOM"
    t.decimal  "weight_per_piece"
    t.integer  "lot_size"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "part_masters", force: :cascade do |t|
    t.string   "part_code"
    t.string   "part_description"
    t.string   "IDE_type"
    t.decimal  "no_of_units_per_IDE"
    t.decimal  "UOM"
    t.decimal  "weight_per_piece"
    t.integer  "lot_size"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "sensors", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "kind"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sensors", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "kind"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shift_masters", force: :cascade do |t|
    t.string   "shift"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shift_masters", force: :cascade do |t|
    t.string   "shift"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trackers", force: :cascade do |t|
    t.integer  "wb_id"
    t.string   "part_code"
    t.integer  "employee_id"
    t.integer  "shift"
    t.integer  "device_id"
    t.integer  "count"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "target"
  end

  create_table "trackers", force: :cascade do |t|
    t.integer  "wb_id"
    t.string   "part_code"
    t.integer  "employee_id"
    t.integer  "shift"
    t.integer  "device_id"
    t.integer  "count"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "target"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "idx_108605_index_users_on_email", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "idx_108605_index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "idx_108605_index_users_on_email", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "idx_108605_index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weight_calculators", force: :cascade do |t|
    t.string   "part_code"
    t.decimal  "wpp"
    t.decimal  "count"
    t.integer  "idm"
    t.decimal  "mpq"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workbench_masters", force: :cascade do |t|
    t.integer  "machine_id"
    t.string   "machine_name"
    t.integer  "machine_throughput"
    t.string   "machine_status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "workbench_masters", force: :cascade do |t|
    t.integer  "machine_id"
    t.string   "machine_name"
    t.integer  "machine_throughput"
    t.string   "machine_status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
