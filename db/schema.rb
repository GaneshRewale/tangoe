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

ActiveRecord::Schema.define(version: 2023_01_03_210424) do

  create_table "slot_collections", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "slots_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slots_id"], name: "index_slot_collections_on_slots_id"
  end

  create_table "slots", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "total_capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "slot_collections", "slots", column: "slots_id"
end
