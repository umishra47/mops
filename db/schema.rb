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

ActiveRecord::Schema.define(version: 20140102112153) do

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

  create_table "instance_types", force: true do |t|
    t.string   "name"
    t.decimal  "memory"
    t.decimal  "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instances", force: true do |t|
    t.string   "name"
    t.string   "ec2_instance_id"
    t.string   "ami"
    t.string   "status"
    t.datetime "launch_time"
    t.integer  "user_id"
    t.string   "instance_type"
    t.decimal  "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instances", ["user_id"], name: "index_instances_on_user_id", using: :btree

  create_table "subscriptions", force: true do |t|
    t.string   "ami"
    t.string   "type"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "notify_date"
    t.integer  "user_id"
    t.integer  "instance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["instance_id"], name: "index_subscriptions_on_instance_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: true do |t|
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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
