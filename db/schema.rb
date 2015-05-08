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

ActiveRecord::Schema.define(version: 20150508173254) do

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.string   "name"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "admins_roles", id: false, force: :cascade do |t|
    t.integer "admin_id"
    t.integer "role_id"
  end

  add_index "admins_roles", ["admin_id", "role_id"], name: "index_admins_roles_on_admin_id_and_role_id"

  create_table "base_regions", force: :cascade do |t|
    t.integer  "parentid",    null: false
    t.string   "name",        null: false
    t.string   "code",        null: false
    t.string   "parent",      null: false
    t.integer  "region_type", null: false
    t.integer  "status",      null: false
    t.integer  "iscity",      null: false
    t.string   "pingyin",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "base_regions", ["iscity"], name: "index_base_regions_on_iscity"
  add_index "base_regions", ["parentid"], name: "index_base_regions_on_parentid"
  add_index "base_regions", ["region_type"], name: "index_base_regions_on_region_type"

  create_table "businesses", force: :cascade do |t|
    t.string   "name",                   limit: 255,              null: false
    t.string   "operating_license",      limit: 255,              null: false
    t.string   "legal_person_name",      limit: 255,              null: false
    t.string   "legal_person_photo",     limit: 255,              null: false
    t.integer  "business_status",        limit: 4,   default: 0
    t.integer  "admin_id",               limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "businesses", ["email"], name: "index_businesses_on_email", unique: true
  add_index "businesses", ["reset_password_token"], name: "index_businesses_on_reset_password_token", unique: true

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",     limit: 4,               null: false
    t.float    "money",       limit: 24,              null: false
    t.integer  "ticket_id",   limit: 4,               null: false
    t.integer  "business_id", limit: 4,               null: false
    t.integer  "status",      limit: 4,   default: 0
    t.string   "user_number", limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "scenic_types", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "scenics", force: :cascade do |t|
    t.string   "name",           limit: 255, null: false
    t.string   "picture",        limit: 255, null: false
    t.string   "manager_name",   limit: 255, null: false
    t.string   "manager_number", limit: 255, null: false
    t.integer  "business_id",    limit: 4
    t.integer  "scenic_type_id", limit: 4
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "ticket_types", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.float    "discount",   limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "name",           limit: 255,               null: false
    t.float    "price",          limit: 24,                null: false
    t.integer  "scenic_id",      limit: 4,                 null: false
    t.string   "picture",        limit: 255
    t.text     "description",    limit: 65535
    t.integer  "ticket_type_id", limit: 4,                 null: false
    t.integer  "status",         limit: 4,     default: 0
    t.integer  "admin_id",       limit: 4
    t.integer  "business_id",    limit: 4,                 null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "province"
    t.string   "city"
    t.time     "status_time"
  end

  create_table "users", force: :cascade do |t|
    t.string   "account",         limit: 255,             null: false
    t.string   "name",            limit: 255,             null: false
    t.string   "password_digest", limit: 255,             null: false
    t.string   "phone",           limit: 255,             null: false
    t.integer  "user_identity",   limit: 4,   default: 0
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

end
