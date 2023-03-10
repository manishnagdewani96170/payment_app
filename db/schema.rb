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

ActiveRecord::Schema.define(version: 2022_12_40_152950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name", default: ""
    t.string "email", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email"
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name", default: ""
    t.text "description"
    t.string "email", null: false
    t.string "status", null: false
    t.decimal "total_transaction_sum", precision: 13, scale: 4, default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_merchants_on_email"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "uuid"
    t.string "customer_email", default: ""
    t.string "type"
    t.string "status"
    t.decimal "amount", precision: 13, scale: 4
    t.string "customer_phone"
    t.bigint "merchant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "following_transaction_id"
    t.index ["merchant_id"], name: "index_transactions_on_merchant_id"
  end

end
