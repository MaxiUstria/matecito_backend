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

ActiveRecord::Schema[7.0].define(version: 2022_11_11_180320) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at", precision: nil
    t.datetime "locked_at", precision: nil
    t.datetime "failed_at", precision: nil
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "donations", force: :cascade do |t|
    t.integer "amount", null: false
    t.string "currency", default: "UY", null: false
    t.string "message"
    t.bigint "beneficiary_id", null: false
    t.bigint "donor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beneficiary_id"], name: "index_donations_on_beneficiary_id"
    t.index ["donor_id"], name: "index_donations_on_donor_id"
  end

  create_table "exception_hunter_error_groups", force: :cascade do |t|
    t.string "error_class_name", null: false
    t.string "message"
    t.integer "status", default: 0
    t.text "tags", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message"], name: "index_exception_hunter_error_groups_on_message", opclass: :gin_trgm_ops, using: :gin
    t.index ["status"], name: "index_exception_hunter_error_groups_on_status"
  end

  create_table "exception_hunter_errors", force: :cascade do |t|
    t.string "class_name", null: false
    t.string "message"
    t.datetime "occurred_at", precision: nil, null: false
    t.json "environment_data"
    t.json "custom_data"
    t.json "user_data"
    t.string "backtrace", default: [], array: true
    t.bigint "error_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["error_group_id"], name: "index_exception_hunter_errors_on_error_group_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "action", null: false
    t.string "message", null: false
    t.boolean "read", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action"], name: "index_notifications_on_action"
    t.index ["read"], name: "index_notifications_on_read"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "objectives", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.string "state", default: "active", null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.integer "target_amount", null: false
    t.integer "current_amount", default: 0, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_objectives_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.integer "category", default: 0, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_settings_on_key", unique: true
  end

  create_table "social_networks", force: :cascade do |t|
    t.string "url", null: false
    t.integer "app", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "app"], name: "index_social_networks_on_user_id_and_app", unique: true
    t.index ["user_id"], name: "index_social_networks_on_user_id"
  end

  create_table "trophies", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.integer "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_trophies_on_name", unique: true
  end

  create_table "user_categories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_user_categories_on_category_id"
    t.index ["user_id", "category_id"], name: "index_user_categories_on_user_id_and_category_id", unique: true
    t.index ["user_id"], name: "index_user_categories_on_user_id"
  end

  create_table "user_followers", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id", "user_id"], name: "index_user_followers_on_follower_id_and_user_id", unique: true
    t.index ["follower_id"], name: "index_user_followers_on_follower_id"
    t.index ["user_id"], name: "index_user_followers_on_user_id"
  end

  create_table "user_settings", force: :cascade do |t|
    t.integer "category", default: 0, null: false
    t.string "value", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_settings_on_user_id"
  end

  create_table "user_trophies", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.bigint "user_id", null: false
    t.bigint "trophy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trophy_id"], name: "index_user_trophies_on_trophy_id"
    t.index ["user_id", "trophy_id"], name: "index_user_trophies_on_user_id_and_trophy_id", unique: true
    t.index ["user_id"], name: "index_user_trophies_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.boolean "allow_password_change", default: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.string "username", default: ""
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.json "tokens"
    t.text "description"
    t.boolean "is_npo?"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "donations", "users", column: "beneficiary_id"
  add_foreign_key "donations", "users", column: "donor_id"
  add_foreign_key "exception_hunter_errors", "exception_hunter_error_groups", column: "error_group_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "objectives", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "social_networks", "users"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_categories", "users"
  add_foreign_key "user_followers", "users"
  add_foreign_key "user_followers", "users", column: "follower_id"
  add_foreign_key "user_settings", "users"
  add_foreign_key "user_trophies", "trophies"
  add_foreign_key "user_trophies", "users"
end
