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

ActiveRecord::Schema.define(version: 20141129020602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "analyzed_foods", force: true do |t|
    t.string   "name",                                null: false
    t.text     "description"
    t.integer  "category"
    t.integer  "food_group"
    t.string   "barcode"
    t.string   "barcode_type"
    t.string   "brand"
    t.float    "calories"
    t.float    "protein"
    t.float    "total_fat"
    t.float    "saturated_fat"
    t.float    "trans_fat"
    t.float    "polyunsaturated_fat"
    t.float    "omega_6"
    t.float    "omega_3"
    t.float    "monounsaturated_fat"
    t.float    "cholesteral"
    t.float    "sodium"
    t.float    "potassium"
    t.float    "caffeine"
    t.float    "total_carbohydrates"
    t.float    "dietary_fiber"
    t.float    "sugars"
    t.float    "vitamin_a"
    t.float    "vitamin_b"
    t.float    "calcium"
    t.float    "iron"
    t.float    "serving_size"
    t.integer  "serving_size_type"
    t.string   "location"
    t.string   "user_ip"
    t.string   "user_email"
    t.boolean  "is_edited",           default: false
    t.boolean  "is_mergeable",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foods", force: true do |t|
    t.string   "name",                                null: false
    t.text     "description"
    t.integer  "category"
    t.integer  "food_group"
    t.string   "barcode"
    t.string   "barcode_type"
    t.string   "brand"
    t.float    "calories"
    t.float    "protein"
    t.float    "total_fat"
    t.float    "saturated_fat"
    t.float    "trans_fat"
    t.float    "polyunsaturated_fat"
    t.float    "omega_6"
    t.float    "omega_3"
    t.float    "monounsaturated_fat"
    t.float    "cholesteral"
    t.float    "sodium"
    t.float    "potassium"
    t.float    "caffeine"
    t.float    "total_carbohydrates"
    t.float    "dietary_fiber"
    t.float    "sugars"
    t.float    "vitamin_a"
    t.float    "vitamin_b"
    t.float    "calcium"
    t.float    "iron"
    t.float    "serving_size"
    t.integer  "serving_size_type"
    t.string   "location"
    t.string   "user_ip"
    t.string   "user_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_edited"
    t.boolean  "is_mergeable",        default: false
  end

  create_table "logs", force: true do |t|
    t.integer  "start_id"
    t.integer  "end_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
