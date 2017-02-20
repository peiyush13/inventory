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

ActiveRecord::Schema.define(version: 20160917101718) do

  create_table "admins", primary_key: "email", force: :cascade do |t|
    t.integer  "budget",                 limit: 4,   default: 0,   null: false
    t.string   "name",                   limit: 55
    t.string   "role",                   limit: 55,  default: "0"
    t.string   "encrypted_password",     limit: 255, default: "",  null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "customers", primary_key: "c_id", force: :cascade do |t|
    t.string   "customer_name", limit: 50,    null: false
    t.string   "contact_no",    limit: 13
    t.text     "address",       limit: 65535, null: false
    t.datetime "created_at",                  null: false
  end

  add_index "customers", ["contact_no"], name: "contact_no", unique: true, using: :btree
  add_index "customers", ["contact_no"], name: "contact_no_index", using: :btree
  add_index "customers", ["contact_no"], name: "contactindex", using: :btree
  add_index "customers", ["customer_name"], name: "customer_name_index", using: :btree

  create_table "expense_accounts", primary_key: "e_id", force: :cascade do |t|
    t.text    "description", limit: 65535, null: false
    t.integer "cost",        limit: 4,     null: false
    t.date    "dated"
    t.string  "title",       limit: 50
    t.string  "admin_email", limit: 55
  end

  add_index "expense_accounts", ["admin_email"], name: "admin_email", using: :btree

  create_table "payment_accounts", id: false, force: :cascade do |t|
    t.integer  "purchase_account_id", limit: 4
    t.integer  "payment_no",          limit: 4
    t.float    "amount",              limit: 24
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "payment_accounts", ["purchase_account_id"], name: "index_payment_accounts_on_purchase_account_id", using: :btree

  create_table "purchase_accounts", primary_key: "bill_no", force: :cascade do |t|
    t.string   "company_name", limit: 50,  null: false
    t.float    "cost",         limit: 24,  null: false
    t.string   "place",        limit: 50,  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "admin_email",  limit: 255
  end

  add_index "purchase_accounts", ["admin_email"], name: "fk_admin", using: :btree

  create_table "purchase_details", id: false, force: :cascade do |t|
    t.integer "purchase_account_id", limit: 4
    t.integer "stock_list_id",       limit: 4
    t.float   "quantity",            limit: 24
    t.float   "price",               limit: 24
  end

  add_index "purchase_details", ["purchase_account_id"], name: "index_purchase_details_on_purchase_account_id", using: :btree
  add_index "purchase_details", ["stock_list_id"], name: "index_purchase_details_on_stock_list_id", using: :btree

  create_table "sales", primary_key: "sale_no", force: :cascade do |t|
    t.integer  "customer_id", limit: 4
    t.float    "total",       limit: 24, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sales", ["customer_id"], name: "index_sales_on_customer_id", using: :btree

  create_table "sales_details", id: false, force: :cascade do |t|
    t.integer "sale_id",       limit: 4
    t.integer "stock_list_id", limit: 4
    t.float   "quantity",      limit: 24
  end

  add_index "sales_details", ["sale_id"], name: "index_sales_details_on_sale_id", using: :btree
  add_index "sales_details", ["stock_list_id"], name: "index_sales_details_on_stock_list_id", using: :btree

  create_table "stock_lists", primary_key: "item_id", force: :cascade do |t|
    t.string   "item_name",   limit: 50,             null: false
    t.integer  "price",       limit: 4,              null: false
    t.integer  "stock",       limit: 4,  default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.date     "expiry_date"
    t.float    "MRP",         limit: 24
  end

  add_foreign_key "expense_accounts", "admins", column: "admin_email", primary_key: "email", name: "expense_accounts_ibfk_1"
  add_foreign_key "purchase_accounts", "admins", column: "admin_email", primary_key: "email", name: "fk_admin"
end
