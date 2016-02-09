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

ActiveRecord::Schema.define(version: 20160209161045) do

  create_table "accepted_items", force: :cascade do |t|
    t.integer  "decision_id",      limit: 4
    t.integer  "required_item_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "color",      limit: 4
  end

  create_table "decisions", force: :cascade do |t|
    t.integer  "helper_id",   limit: 4
    t.integer  "request_id",  limit: 4
    t.string   "status",      limit: 255,   default: "new"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.text     "description", limit: 65535
  end

  create_table "helped_items", force: :cascade do |t|
    t.integer  "count",       limit: 4, default: 1
    t.integer  "user_id",     limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "status",         limit: 255, default: "new"
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "message_type",   limit: 4
    t.integer  "reason_user_id", limit: 4
    t.integer  "request_id",     limit: 4
  end

  create_table "requests", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.text     "description",        limit: 65535
    t.integer  "user_id",            limit: 4
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size",    limit: 4
    t.datetime "photo_updated_at"
    t.string   "status",             limit: 255,   default: "actual"
  end

  create_table "required_items", force: :cascade do |t|
    t.integer  "request_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",       null: false
    t.string   "encrypted_password",     limit: 255,   default: "",       null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "name",                   limit: 255
    t.text     "info",                   limit: 65535
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.string   "role",                   limit: 255,   default: "author"
    t.string   "skype",                  limit: 255
    t.string   "phone",                  limit: 255
    t.string   "vkontakte",              limit: 255
    t.string   "vkontakte_name",         limit: 255
    t.string   "facebook",               limit: 255
    t.string   "facebook_name",          limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
