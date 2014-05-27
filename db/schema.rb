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

ActiveRecord::Schema.define(version: 20140526112137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_images", force: true do |t|
    t.string   "name"
    t.string   "hosting"
    t.string   "remote_image_id"
    t.float    "price"
    t.integer  "ram"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "product_types", force: true do |t|
    t.string   "name"
    t.decimal  "memory"
    t.decimal  "cost_per_month"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "web_name"
    t.string   "product_id"
    t.string   "name"
    t.string   "image_id"
    t.string   "status"
    t.datetime "launch_time"
    t.string   "region"
    t.string   "product_type"
    t.integer  "size_type"
    t.decimal  "cost"
    t.integer  "region_id"
    t.boolean  "backups_active",  default: false
    t.string   "backups"
    t.string   "snapshots"
    t.boolean  "locked",          default: false
    t.string   "profileId"
    t.string   "dns_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "private_ssh_key"
    t.text     "public_ssh_key"
    t.integer  "custom_image_id"
  end

  create_table "region_types", force: true do |t|
    t.integer  "region_id"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "size_types", force: true do |t|
    t.integer  "size_id"
    t.integer  "disk"
    t.integer  "cpu"
    t.decimal  "memory"
    t.decimal  "cost_per_month"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "subscriptions", force: true do |t|
    t.string   "web_type"
    t.string   "image_id"
    t.string   "product_type"
    t.string   "instance_id"
    t.integer  "size_type"
    t.string   "sub_tran"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "notify_date"
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["product_id"], name: "index_subscriptions_on_product_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",          null: false
    t.string   "encrypted_password",     default: "",          null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,           null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "default_region",         default: "us-east-1"
    t.boolean  "is_admin"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
