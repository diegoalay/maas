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

ActiveRecord::Schema.define(version: 2022_03_02_031547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.bigint "user_creator_id"
    t.jsonb "schedule"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "color"
    t.string "first_name"
    t.string "last_name"
    t.integer "role"
    t.bigint "user_creator_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "working_week_available_shifts", force: :cascade do |t|
    t.integer "hour_id"
    t.integer "day_id"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "working_week_id"
    t.bigint "user_id"
    t.index ["day_id"], name: "index_working_week_available_shifts_on_day_id"
    t.index ["hour_id"], name: "index_working_week_available_shifts_on_hour_id"
    t.index ["user_id"], name: "index_working_week_available_shifts_on_user_id"
    t.index ["working_week_id"], name: "index_working_week_available_shifts_on_working_week_id"
  end

  create_table "working_week_confirmed_shifts", force: :cascade do |t|
    t.integer "hour_id"
    t.integer "day_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "working_week_id"
    t.bigint "user_id"
    t.index ["day_id"], name: "index_working_week_confirmed_shifts_on_day_id"
    t.index ["hour_id"], name: "index_working_week_confirmed_shifts_on_hour_id"
    t.index ["user_id"], name: "index_working_week_confirmed_shifts_on_user_id"
    t.index ["working_week_id"], name: "index_working_week_confirmed_shifts_on_working_week_id"
  end

  create_table "working_weeks", force: :cascade do |t|
    t.integer "week_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "service_id"
    t.index ["service_id"], name: "index_working_weeks_on_service_id"
  end

  add_foreign_key "services", "users", column: "user_creator_id"
  add_foreign_key "users", "users", column: "user_creator_id"
  add_foreign_key "working_week_available_shifts", "users"
  add_foreign_key "working_week_available_shifts", "working_weeks"
  add_foreign_key "working_week_confirmed_shifts", "users"
  add_foreign_key "working_week_confirmed_shifts", "working_weeks"
  add_foreign_key "working_weeks", "services"
end
