# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160506141711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "customers", ["name"], name: "index_customers_on_name", unique: true, using: :btree

  create_table "producers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "email"
    t.string   "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "producers", ["name"], name: "index_producers_on_name", unique: true, using: :btree

  create_table "product_adjusts", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "email"
  end

  add_index "product_adjusts", ["product_id"], name: "index_product_adjusts_on_product_id", using: :btree
  add_index "product_adjusts", ["user_id"], name: "index_product_adjusts_on_user_id", using: :btree

  create_table "product_returns", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "product_id"
    t.date     "return_date"
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "product_returns", ["customer_id"], name: "index_product_returns_on_customer_id", using: :btree
  add_index "product_returns", ["product_id"], name: "index_product_returns_on_product_id", using: :btree

  create_table "product_shipments", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "product_id"
    t.date     "ship_date"
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "product_shipments", ["customer_id"], name: "index_product_shipments_on_customer_id", using: :btree
  add_index "product_shipments", ["product_id"], name: "index_product_shipments_on_product_id", using: :btree

  create_table "production_runs", force: :cascade do |t|
    t.integer  "producer_id"
    t.integer  "product_id"
    t.integer  "amount"
    t.date     "mfgd_date"
    t.date     "expiry_date"
    t.string   "lot_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "production_runs", ["producer_id"], name: "index_production_runs_on_producer_id", using: :btree
  add_index "production_runs", ["product_id"], name: "index_production_runs_on_product_id", using: :btree

  create_table "production_runs_supplies", id: false, force: :cascade do |t|
    t.integer "supply_id"
    t.integer "production_run_id"
  end

  add_index "production_runs_supplies", ["production_run_id"], name: "index_production_runs_supplies_on_production_run_id", using: :btree
  add_index "production_runs_supplies", ["supply_id"], name: "index_production_runs_supplies_on_supply_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "amount"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "products", ["name"], name: "index_products_on_name", unique: true, using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "email"
    t.string   "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "suppliers", ["name"], name: "index_suppliers_on_name", unique: true, using: :btree

  create_table "supplies", force: :cascade do |t|
    t.string   "name"
    t.integer  "amount"
    t.string   "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supply_adjusts", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "supply_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "email"
  end

  add_index "supply_adjusts", ["supply_id"], name: "index_supply_adjusts_on_supply_id", using: :btree
  add_index "supply_adjusts", ["user_id"], name: "index_supply_adjusts_on_user_id", using: :btree

  create_table "supply_consumptions", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "supply_id"
    t.integer  "production_run_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "supply_consumptions", ["production_run_id"], name: "index_supply_consumptions_on_production_run_id", using: :btree
  add_index "supply_consumptions", ["supply_id"], name: "index_supply_consumptions_on_supply_id", using: :btree

  create_table "supply_receiveds", force: :cascade do |t|
    t.integer  "amount"
    t.string   "unit"
    t.integer  "supply_id"
    t.integer  "supplier_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "supply_receiveds", ["supplier_id"], name: "index_supply_receiveds_on_supplier_id", using: :btree
  add_index "supply_receiveds", ["supply_id"], name: "index_supply_receiveds_on_supply_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "product_adjusts", "products"
  add_foreign_key "product_adjusts", "users"
  add_foreign_key "product_returns", "customers"
  add_foreign_key "product_returns", "products"
  add_foreign_key "product_shipments", "customers"
  add_foreign_key "product_shipments", "products"
  add_foreign_key "production_runs", "producers"
  add_foreign_key "production_runs", "products"
  add_foreign_key "production_runs_supplies", "production_runs"
  add_foreign_key "production_runs_supplies", "supplies"
  add_foreign_key "supply_adjusts", "supplies"
  add_foreign_key "supply_adjusts", "users"
  add_foreign_key "supply_consumptions", "production_runs"
  add_foreign_key "supply_consumptions", "supplies"
  add_foreign_key "supply_receiveds", "suppliers"
  add_foreign_key "supply_receiveds", "supplies"
end
