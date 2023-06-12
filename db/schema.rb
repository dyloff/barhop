# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_12_111840) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bars", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.float "longitude"
    t.float "latitude"
    t.string "price_range"
    t.float "rating"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.boolean "restaurant", default: false
    t.text "types", default: [], array: true
    t.string "place_id"
  end

  create_table "crawlbars", force: :cascade do |t|
    t.bigint "bar_id", null: false
    t.bigint "crawl_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bar_id"], name: "index_crawlbars_on_bar_id"
    t.index ["crawl_id"], name: "index_crawlbars_on_crawl_id"
  end

  create_table "crawls", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "crawl_name"
    t.boolean "completed"
    t.boolean "public"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_crawls_on_user_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "bar_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bar_id"], name: "index_favourites_on_bar_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "following_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "crawl_id", null: false
    t.bigint "user_id", null: false
    t.float "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crawl_id"], name: "index_reviews_on_crawl_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shared_withs", force: :cascade do |t|
    t.bigint "crawl_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crawl_id"], name: "index_shared_withs_on_crawl_id"
    t.index ["user_id"], name: "index_shared_withs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "crawlbars", "bars"
  add_foreign_key "crawlbars", "crawls"
  add_foreign_key "crawls", "users"
  add_foreign_key "favourites", "bars"
  add_foreign_key "favourites", "users"
  add_foreign_key "reviews", "crawls"
  add_foreign_key "reviews", "users"
  add_foreign_key "shared_withs", "crawls"
  add_foreign_key "shared_withs", "users"
end
