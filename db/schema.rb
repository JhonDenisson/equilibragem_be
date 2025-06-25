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

ActiveRecord::Schema[8.0].define(version: 2025_06_22_233454) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "allocation_rules", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "User reference"
    t.bigint "category_id", null: false, comment: "Category reference"
    t.integer "percentage", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_allocation_rules_on_category_id"
    t.index ["user_id", "category_id"], name: "index_allocation_rules_on_user_id_and_category_id", unique: true
    t.index ["user_id"], name: "index_allocation_rules_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "user_id", comment: "User reference"
    t.string "name", null: false, comment: "Category name"
    t.integer "category_type", null: false, comment: "Category type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "summaries", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "User reference"
    t.integer "month", null: false
    t.integer "year", null: false
    t.decimal "total_income", precision: 10, scale: 2, default: "0.0"
    t.decimal "total_expense", precision: 10, scale: 2, default: "0.0"
    t.decimal "balance", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "month", "year"], name: "index_summaries_on_user_id_and_month_and_year", unique: true
    t.index ["user_id"], name: "index_summaries_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "User reference"
    t.bigint "category_id", null: false, comment: "Category reference"
    t.integer "transaction_type", null: false, comment: "Transaction type"
    t.string "description", comment: "Description of income"
    t.decimal "amount", precision: 10, scale: 2, null: false, comment: "Total amount of income"
    t.datetime "transacted_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "allocation_rules", "categories"
  add_foreign_key "allocation_rules", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "summaries", "users"
end
