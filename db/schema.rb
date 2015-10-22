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

ActiveRecord::Schema.define(version: 20151022160018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "photo_id"
    t.integer  "sale_amount"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["photo_id"], name: "index_order_items_on_photo_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "status_id"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "photo_categories", force: :cascade do |t|
    t.integer  "photo_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "photo_categories", ["category_id"], name: "index_photo_categories_on_category_id", using: :btree
  add_index "photo_categories", ["photo_id"], name: "index_photo_categories_on_photo_id", using: :btree

  create_table "photo_cateogries", force: :cascade do |t|
    t.integer  "photo_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "photo_cateogries", ["category_id"], name: "index_photo_cateogries_on_category_id", using: :btree
  add_index "photo_cateogries", ["photo_id"], name: "index_photo_cateogries_on_photo_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "standard_price"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "store_id"
    t.string   "file"
    t.boolean  "active",         default: true
  end

  add_index "photos", ["store_id"], name: "index_photos_on_store_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "store_admins", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "store_admins", ["store_id"], name: "index_store_admins_on_store_id", using: :btree
  add_index "store_admins", ["user_id"], name: "index_store_admins_on_user_id", using: :btree

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "tagline"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "slug"
    t.integer  "watermark_id"
    t.boolean  "active",       default: true
  end

  add_index "stores", ["user_id"], name: "index_stores_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string  "password_digest"
    t.string  "name"
    t.string  "email"
    t.boolean "platform_admin",  default: false
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "photos"
  add_foreign_key "photo_categories", "categories"
  add_foreign_key "photo_categories", "photos"
  add_foreign_key "photo_cateogries", "categories"
  add_foreign_key "photo_cateogries", "photos"
  add_foreign_key "photos", "stores"
  add_foreign_key "store_admins", "stores"
  add_foreign_key "store_admins", "users"
  add_foreign_key "stores", "users"
end
