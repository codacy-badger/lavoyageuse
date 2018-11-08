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

ActiveRecord::Schema.define(version: 20181108154911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "traveller_id"
    t.integer "host_id"
    t.boolean "suspended", default: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "traveller_id"
    t.integer "host_id"
    t.index ["host_id"], name: "index_messages_on_host_id"
    t.index ["traveller_id"], name: "index_messages_on_assigner_id"
  end

  create_table "moderations", force: :cascade do |t|
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "moderator_id"
    t.integer "moderated_id"
    t.index ["moderated_id"], name: "index_moderations_on_moderated_id"
    t.index ["moderator_id"], name: "index_moderations_on_moderator_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "state"
    t.string "plan_sku"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "EUR", null: false
    t.json "payment"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.integer "duration"
    t.string "price"
  end

  create_table "trips", force: :cascade do |t|
    t.string "beginning"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "traveller_id"
    t.integer "host_id"
    t.string "end"
    t.index ["host_id"], name: "index_trips_on_host_id"
    t.index ["traveller_id"], name: "index_trips_on_assigner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "address"
    t.float "longitude"
    t.float "latitude"
    t.integer "role", default: 0
    t.string "photo"
    t.string "id_card"
    t.string "sentence"
    t.integer "host", default: 0
    t.string "description"
    t.string "home"
    t.string "city"
    t.boolean "admin", default: false, null: false
    t.boolean "moderator", default: false
    t.boolean "premium", default: false
    t.boolean "adulthood"
    t.string "stripe_customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "orders", "users"
end
