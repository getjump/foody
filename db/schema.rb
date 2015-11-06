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

ActiveRecord::Schema.define(version: 20151106095136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "food_tags", force: :cascade do |t|
    t.integer  "food_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "food_tags", ["food_id"], name: "index_food_tags_on_food_id", using: :btree
  add_index "food_tags", ["tag_id"], name: "index_food_tags_on_tag_id", using: :btree

  create_table "foods", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "foods", ["place_id"], name: "index_foods_on_place_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "photo_1x"
    t.integer  "food_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "photos", ["food_id"], name: "index_photos_on_food_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.point    "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "food_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ratings", ["food_id"], name: "index_ratings_on_food_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "device_hash"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "food_tags", "foods"
  add_foreign_key "food_tags", "tags"
  add_foreign_key "foods", "places"
  add_foreign_key "photos", "foods"
  add_foreign_key "ratings", "foods"
  add_foreign_key "ratings", "users"
end
