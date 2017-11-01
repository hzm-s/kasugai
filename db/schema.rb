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

ActiveRecord::Schema.define(version: 20171101102155) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "receptions", force: :cascade do |t|
    t.string "token", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "email", null: false
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "sign_ups", force: :cascade do |t|
    t.bigint "reception_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.index ["reception_id"], name: "index_sign_ups_on_reception_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
  end

  add_foreign_key "registrations", "users"
end
