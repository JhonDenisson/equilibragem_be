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

ActiveRecord::Schema[8.0].define(version: 2025_06_22_035225) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "User reference"
    t.bigint "category_id", null: false, comment: "Category reference"
    t.integer "percent", null: false, comment: "percentage of the remaining balance that will be allocated to the budget"
    t.integer "value_cents", null: false, comment: "Value cents of the budget"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_budgets_on_category_id"
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false, comment: "Category name"
    t.integer "category_type", null: false, comment: "Category type"
    t.bigint "user_id", null: false, comment: "User reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "User reference"
    t.bigint "categories_id", null: false, comment: "Category reference"
    t.string "description", comment: "Description of income"
    t.integer "amount", null: false, comment: "Total amount of income"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categories_id"], name: "index_expenses_on_categories_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "User reference"
    t.bigint "categories_id", null: false, comment: "Category reference"
    t.string "description", comment: "Description of income"
    t.integer "amount", null: false, comment: "Total amount of income"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categories_id"], name: "index_incomes_on_categories_id"
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "User reference"
    t.bigint "categories_id", null: false, comment: "Category reference"
    t.string "description", comment: "Description of income"
    t.integer "amount", null: false, comment: "Total amount of income"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categories_id"], name: "index_transactions_on_categories_id"
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
end
