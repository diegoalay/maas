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

ActiveRecord::Schema.define(version: 2022_02_27_224129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.bigint "user_creator_id"
    t.jsonb "schedule"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shift_availables", force: :cascade do |t|
    t.integer "hour_id"
    t.integer "day_id"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "shift_id"
    t.bigint "user_id"
    t.index ["shift_id"], name: "index_shift_availables_on_shift_id"
    t.index ["user_id"], name: "index_shift_availables_on_user_id"
  end

  create_table "shift_confirmations", force: :cascade do |t|
    t.integer "hour_id"
    t.integer "day_id"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "shift_id"
    t.bigint "user_id"
    t.index ["shift_id"], name: "index_shift_confirmations_on_shift_id"
    t.index ["user_id"], name: "index_shift_confirmations_on_user_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.integer "week_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "service_id"
    t.index ["service_id"], name: "index_shifts_on_service_id"
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

  add_foreign_key "services", "users", column: "user_creator_id"
  add_foreign_key "shift_availables", "shifts"
  add_foreign_key "shift_availables", "users"
  add_foreign_key "shift_confirmations", "shifts"
  add_foreign_key "shift_confirmations", "users"
  add_foreign_key "shifts", "services"
  add_foreign_key "users", "users", column: "user_creator_id"
end
