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

ActiveRecord::Schema[8.1].define(version: 2026_05_07_172945) do
  create_table "order_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "add_ingredients"
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "order_id", null: false
    t.text "remove_ingredients"
    t.string "size"
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "discount_code"
    t.string "external_id", null: false
    t.datetime "ordered_at"
    t.text "promotion_codes"
    t.string "state", null: false
    t.decimal "total_price", precision: 10
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_orders_on_external_id", unique: true
  end

  add_foreign_key "order_items", "orders"
end
