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

ActiveRecord::Schema.define(version: 20131012152510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "carts", force: true do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "feedbacks", force: true do |t|
    t.string   "email",      null: false
    t.text     "message",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "fulfillments", force: true do |t|
    t.integer  "order_id",      null: false
    t.string   "service"
    t.string   "tracking_code"
    t.date     "shipped_on",    null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "line_items", force: true do |t|
    t.integer  "cart_id",                null: false
    t.uuid     "photo_id",               null: false
    t.integer  "variant_id",             null: false
    t.integer  "quantity",   default: 1, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "orders", force: true do |t|
    t.integer  "cart_id",                                null: false
    t.string   "name",                                   null: false
    t.string   "email",                                  null: false
    t.string   "address1",                               null: false
    t.string   "address2"
    t.string   "city",                                   null: false
    t.string   "state",                                  null: false
    t.string   "postal_code",                            null: false
    t.string   "transaction_id"
    t.decimal  "total",          precision: 8, scale: 2
    t.decimal  "shipping",       precision: 8, scale: 2
    t.decimal  "tax",            precision: 8, scale: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "photos", id: :uuid, force: true do |t|
    t.string   "url",        null: false
    t.integer  "width",      null: false
    t.integer  "height",     null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: true do |t|
    t.string   "name",        null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: true do |t|
    t.string   "oauth_token",                       null: false
    t.integer  "oauth_id",                          null: false
    t.string   "username",                          null: false
    t.string   "name"
    t.string   "avatar_url",                        null: false
    t.boolean  "send_process_email", default: true, null: false
    t.boolean  "send_ship_email",    default: true, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "users", ["oauth_id"], name: "index_users_on_oauth_id", unique: true, using: :btree

  create_table "variants", force: true do |t|
    t.integer  "product_id",                                        null: false
    t.boolean  "active",                             default: true, null: false
    t.string   "sku",                                               null: false
    t.integer  "number",                                            null: false
    t.integer  "size",                                              null: false
    t.decimal  "price",      precision: 8, scale: 2,                null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

end
