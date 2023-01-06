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

ActiveRecord::Schema[7.0].define(version: 2023_01_03_213153) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "debits", force: :cascade do |t|
    t.string "title"
    t.float "price"
    t.boolean "paid"
    t.bigint "owner_id", null: false
    t.bigint "month_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["month_id"], name: "index_debits_on_month_id"
    t.index ["owner_id"], name: "index_debits_on_owner_id"
  end

  create_table "months", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "year_id"
    t.index ["user_id"], name: "index_months_on_user_id"
    t.index ["year_id"], name: "index_months_on_year_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "years", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_years_on_user_id"
  end

  add_foreign_key "debits", "months"
  add_foreign_key "debits", "owners"
  add_foreign_key "months", "users"
  add_foreign_key "months", "years"
  add_foreign_key "years", "users"
end
