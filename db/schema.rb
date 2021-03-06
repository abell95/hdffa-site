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

ActiveRecord::Schema.define(version: 2021_04_29_022854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "categories_partners", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "partner_id", null: false
    t.index ["category_id"], name: "index_categories_partners_on_category_id"
    t.index ["partner_id"], name: "index_categories_partners_on_partner_id"
  end

  create_table "dietaries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dietaries_partners", id: false, force: :cascade do |t|
    t.bigint "dietary_id", null: false
    t.bigint "partner_id", null: false
    t.index ["dietary_id"], name: "index_dietaries_partners_on_dietary_id"
    t.index ["partner_id"], name: "index_dietaries_partners_on_partner_id"
  end

  create_table "featured_listings", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.bigint "partner_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_notes_on_partner_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "partners", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "description"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "email"
    t.string "phone"
    t.string "url"
    t.string "hours_of_operation"
    t.string "keywords"
    t.text "discount"
    t.bigint "featured_listing_id"
    t.string "twitter"
    t.string "instagram"
    t.string "facebook"
    t.index ["featured_listing_id"], name: "index_partners_on_featured_listing_id"
    t.index ["name"], name: "index_partners_on_name", unique: true
  end

  create_table "partners_procurements", id: false, force: :cascade do |t|
    t.bigint "procurement_id", null: false
    t.bigint "partner_id", null: false
    t.index ["partner_id"], name: "index_partners_procurements_on_partner_id"
    t.index ["procurement_id"], name: "index_partners_procurements_on_procurement_id"
  end

  create_table "partners_products", id: false, force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "partner_id", null: false
    t.index ["partner_id"], name: "index_partners_products_on_partner_id"
    t.index ["product_id"], name: "index_partners_products_on_product_id"
  end

  create_table "partners_values", id: false, force: :cascade do |t|
    t.bigint "value_id", null: false
    t.bigint "partner_id", null: false
    t.index ["partner_id"], name: "index_partners_values_on_partner_id"
    t.index ["value_id"], name: "index_partners_values_on_value_id"
  end

  create_table "procurements", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "role", default: 0, null: false
    t.boolean "active", default: true, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "values", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "notes", "partners"
  add_foreign_key "notes", "users"
  add_foreign_key "partners", "featured_listings"
end
