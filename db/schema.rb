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

ActiveRecord::Schema.define(version: 2019_04_23_161112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.citext "title"
    t.index ["title"], name: "index_books_on_title", unique: true
  end

  create_table "i_real_files", force: :cascade do |t|
    t.integer "tune_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "song_hash", default: {}
  end

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tune_id"
    t.integer "book_id"
    t.string "page"
    t.index ["tune_id", "book_id"], name: "index_locations_on_tune_id_and_book_id"
  end

  create_table "query_logs", force: :cascade do |t|
    t.string "ip"
    t.string "query"
    t.datetime "created_at", null: false
  end

  create_table "tunes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.citext "title"
    t.index ["title"], name: "index_tunes_on_title", unique: true
  end

end
