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

ActiveRecord::Schema.define(version: 20171206050428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "activity_list_projects", force: :cascade do |t|
    t.date "date", null: false
    t.string "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_activity_list_projects_on_project_id"
  end

  create_table "bookmarked_issues", force: :cascade do |t|
    t.string "issue_id", null: false
    t.datetime "created_at", null: false
    t.index ["issue_id"], name: "index_bookmarked_issues_on_issue_id", unique: true
  end

  create_table "closed_issues", force: :cascade do |t|
    t.string "issue_id", null: false
    t.datetime "created_at", null: false
    t.index ["issue_id"], name: "index_closed_issues_on_issue_id", unique: true
  end

  create_table "issue_appearances", force: :cascade do |t|
    t.string "issue_id", null: false
    t.bigint "project_member_id", null: false
    t.datetime "created_at", null: false
    t.index ["issue_id", "project_member_id"], name: "index_issue_appearances_on_issue_id_and_project_member_id", unique: true
    t.index ["project_member_id"], name: "index_issue_appearances_on_project_member_id"
  end

  create_table "issue_comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "issue_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.index ["user_id"], name: "index_issue_comments_on_user_id"
  end

  create_table "issues", id: :string, force: :cascade do |t|
    t.string "project_id", null: false
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.index ["user_id"], name: "index_issues_on_user_id"
  end

  create_table "opened_issues", force: :cascade do |t|
    t.string "project_id", null: false
    t.string "issue_id", null: false
    t.integer "priority_order"
    t.index ["issue_id"], name: "index_opened_issues_on_issue_id", unique: true
  end

  create_table "project_activities", force: :cascade do |t|
    t.bigint "activity_list_project_id", null: false
    t.bigint "user_id", null: false
    t.string "activity", null: false
    t.datetime "created_at", null: false
    t.index ["activity_list_project_id"], name: "index_project_activities_on_activity_list_project_id"
    t.index ["user_id"], name: "index_project_activities_on_user_id"
  end

  create_table "project_activities_issue_comments", force: :cascade do |t|
    t.bigint "project_activity_id", null: false
    t.string "issue_id", null: false
    t.string "issue_title", null: false
    t.string "content", null: false
    t.index ["project_activity_id"], name: "index_project_activities_issue_comments_on_project_activity_id"
  end

  create_table "project_activities_issues", force: :cascade do |t|
    t.bigint "project_activity_id", null: false
    t.string "issue_id", null: false
    t.string "title", null: false
    t.index ["project_activity_id"], name: "index_project_activities_issues_on_project_activity_id"
  end

  create_table "project_members", force: :cascade do |t|
    t.string "project_id", null: false
    t.bigint "user_id", null: false
    t.index ["project_id", "user_id"], name: "index_project_members_on_project_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_project_members_on_user_id"
  end

  create_table "projects", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
  end

  create_table "remembered_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.index ["token"], name: "index_remembered_users_on_token", unique: true
    t.index ["user_id"], name: "index_remembered_users_on_user_id", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "sign_ins", force: :cascade do |t|
    t.string "token", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.index ["email"], name: "index_sign_ins_on_email", unique: true
    t.index ["token"], name: "index_sign_ins_on_token", unique: true
  end

  create_table "sign_ups", force: :cascade do |t|
    t.string "token", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.index ["email"], name: "index_sign_ups_on_email", unique: true
    t.index ["token"], name: "index_sign_ups_on_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "initials", null: false
    t.string "theme", null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "activity_list_projects", "projects"
  add_foreign_key "bookmarked_issues", "issues"
  add_foreign_key "closed_issues", "issues"
  add_foreign_key "issue_appearances", "issues"
  add_foreign_key "issue_appearances", "project_members"
  add_foreign_key "issue_comments", "issues"
  add_foreign_key "issue_comments", "users"
  add_foreign_key "issues", "projects"
  add_foreign_key "issues", "users"
  add_foreign_key "opened_issues", "issues"
  add_foreign_key "project_activities", "activity_list_projects"
  add_foreign_key "project_activities", "users"
  add_foreign_key "project_activities_issue_comments", "project_activities"
  add_foreign_key "project_activities_issues", "project_activities"
  add_foreign_key "project_members", "projects"
  add_foreign_key "project_members", "users"
  add_foreign_key "remembered_users", "users"
end
