# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_15_141849) do

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "phone"
    t.string "encrypted_password", default: "", null: false
    t.date "birthday"
    t.integer "role", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "remember_created_at"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["phone"], name: "index_admins_on_phone", unique: true
  end

  create_table "contract_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "date_changed"
    t.json "description"
    t.integer "code"
    t.bigint "admin_id"
    t.bigint "contract_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_contract_histories_on_admin_id"
    t.index ["contract_id"], name: "index_contract_histories_on_contract_id"
  end

  create_table "contracts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "holder_id"
    t.integer "room_id"
    t.decimal "room_price", precision: 10
    t.decimal "deposited_money", precision: 10
    t.date "started_date"
    t.date "ended_date"
    t.datetime "deleted_at"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "floors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "floor_number"
    t.datetime "deleted_at"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "date_export", null: false
    t.decimal "reduce", precision: 10
    t.decimal "total", precision: 10, null: false
    t.bigint "contract_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "day_lived", default: 1, null: false
    t.integer "day_in_month", default: 1, null: false
    t.datetime "deleted_at"
    t.boolean "active", default: true, null: false
    t.index ["contract_id"], name: "index_invoices_on_contract_id"
    t.index ["date_export"], name: "index_invoices_on_date_export"
  end

  create_table "resource_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.float "begin_number", null: false
    t.float "end_number", null: false
    t.float "quantity", null: false
    t.string "unit", null: false
    t.decimal "total", precision: 10, null: false
    t.decimal "unit_price", precision: 10, null: false
    t.string "type", null: false
    t.bigint "invoice_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.boolean "active", default: true, null: false
    t.index ["invoice_id"], name: "index_resource_items_on_invoice_id"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "room_number"
    t.datetime "deleted_at"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "floor_id"
    t.integer "status", default: 1, null: false
    t.integer "holder_id"
    t.float "area"
    t.index ["floor_id"], name: "index_rooms_on_floor_id"
  end

  create_table "service_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "quantity", null: false
    t.string "unit", null: false
    t.decimal "total", precision: 10, null: false
    t.decimal "unit_price", precision: 10, null: false
    t.string "type", null: false
    t.bigint "invoice_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.boolean "active", default: true, null: false
    t.index ["invoice_id"], name: "index_service_items_on_invoice_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.datetime "birthday"
    t.datetime "deleted_at"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "room_id"
    t.string "identity_card"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["room_id"], name: "index_users_on_room_id"
  end

end
