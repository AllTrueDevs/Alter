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

ActiveRecord::Schema.define(version: 20160512111913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accepted_items", force: :cascade do |t|
    t.integer  "decision_id"
    t.integer  "required_item_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "accepted_items", ["decision_id"], name: "index_accepted_items_on_decision_id", using: :btree
  add_index "accepted_items", ["required_item_id"], name: "index_accepted_items_on_required_item_id", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "name"
    t.text     "body"
    t.string   "src"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "user_id"
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.string   "attachment_type"
    t.integer  "message_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "content_file_name"
    t.string   "content_content_type"
    t.integer  "content_file_size"
    t.datetime "content_updated_at"
  end

  add_index "attachments", ["message_id"], name: "index_attachments_on_message_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "color"
  end

  create_table "decisions", force: :cascade do |t|
    t.string   "status",      default: "new"
    t.integer  "helper_id"
    t.integer  "request_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "description"
  end

  add_index "decisions", ["helper_id"], name: "index_decisions_on_helper_id", using: :btree
  add_index "decisions", ["request_id"], name: "index_decisions_on_request_id", using: :btree

  create_table "helped_items", force: :cascade do |t|
    t.integer  "count",       default: 1
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "helped_items", ["category_id"], name: "index_helped_items_on_category_id", using: :btree
  add_index "helped_items", ["user_id"], name: "index_helped_items_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "message_type"
    t.text     "body"
    t.string   "status",       default: "new"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "request_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id", using: :btree
  add_index "messages", ["request_id"], name: "index_messages_on_request_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "status",         default: "new"
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "message_type"
    t.integer  "request_id"
    t.integer  "reason_user_id"
  end

  add_index "notifications", ["reason_user_id"], name: "index_notifications_on_reason_user_id", using: :btree
  add_index "notifications", ["request_id"], name: "index_notifications_on_request_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "requests", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "status",             default: "unchecked"
  end

  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "required_items", force: :cascade do |t|
    t.integer  "request_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "required_items", ["category_id"], name: "index_required_items_on_category_id", using: :btree
  add_index "required_items", ["request_id"], name: "index_required_items_on_request_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "user_tags", force: :cascade do |t|
    t.string   "value"
    t.string   "tag_type"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_tags", ["user_id"], name: "index_user_tags_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "name"
    t.text     "info"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "role",                   default: "author"
    t.string   "skype"
    t.string   "phone"
    t.string   "vkontakte"
    t.string   "vkontakte_name"
    t.string   "facebook"
    t.string   "facebook_name"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "accepted_items", "decisions"
  add_foreign_key "accepted_items", "required_items"
  add_foreign_key "articles", "users"
  add_foreign_key "attachments", "messages"
  add_foreign_key "decisions", "requests"
  add_foreign_key "decisions", "users", column: "helper_id"
  add_foreign_key "helped_items", "categories"
  add_foreign_key "helped_items", "users"
  add_foreign_key "messages", "requests"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "notifications", "requests"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "reason_user_id"
  add_foreign_key "requests", "users"
  add_foreign_key "required_items", "categories"
  add_foreign_key "required_items", "requests"
  add_foreign_key "user_tags", "users"
end
