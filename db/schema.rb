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

ActiveRecord::Schema.define(version: 2022_06_02_184455) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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

  create_table "ahoy_messages", force: :cascade do |t|
    t.string "user_type"
    t.integer "user_id"
    t.text "to"
    t.string "mailer"
    t.text "subject"
    t.text "content"
    t.datetime "sent_at"
    t.index ["user_type", "user_id"], name: "index_ahoy_messages_on_user_type_and_user_id"
  end

  create_table "asana_asana_families", force: :cascade do |t|
    t.integer "asana_id", null: false
    t.integer "asana_family_id", null: false
    t.index ["asana_family_id"], name: "index_asana_asana_families_on_asana_family_id"
    t.index ["asana_id"], name: "index_asana_asana_families_on_asana_id"
  end

  create_table "asana_families", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asana_names", force: :cascade do |t|
    t.string "name"
    t.string "language_code"
    t.integer "asana_id", null: false
    t.boolean "main"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["asana_id"], name: "index_asana_names_on_asana_id"
  end

  create_table "asanas", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "blog_posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "slug"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "summary"
    t.datetime "published_at"
    t.text "content_rendered"
    t.index ["slug"], name: "index_blog_posts_on_slug", unique: true
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "place_id", null: false
    t.integer "style_id", null: false
    t.string "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "note"
    t.integer "row_order"
    t.boolean "active"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "dayofweek"
    t.index ["place_id"], name: "index_courses_on_place_id"
    t.index ["slug"], name: "index_courses_on_slug", unique: true
    t.index ["style_id"], name: "index_courses_on_style_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "contact"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "gender"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "cron"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "style_id", null: false
    t.string "name"
    t.datetime "date_start"
    t.datetime "date_end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.boolean "active"
    t.integer "row_order"
    t.text "description"
    t.index ["slug"], name: "index_lessons_on_slug", unique: true
    t.index ["style_id"], name: "index_lessons_on_style_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.string "building_name"
    t.string "note"
    t.string "address"
    t.integer "row_order"
    t.boolean "active"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "pricing_note"
    t.index ["name"], name: "index_places_on_name", unique: true
    t.index ["slug"], name: "index_places_on_slug", unique: true
  end

  create_table "seminars", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "description_rendered"
    t.integer "row_order"
    t.string "slug"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_seminars_on_slug", unique: true
  end

  create_table "site_settings", force: :cascade do |t|
    t.string "key", null: false
    t.text "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "value_rendered"
    t.string "kind"
  end

  create_table "styles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.boolean "active"
    t.integer "row_order"
    t.string "description"
    t.index ["slug"], name: "index_styles_on_slug", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "date_start"
    t.datetime "date_end"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.datetime "terms_accepted_at"
    t.datetime "mark_paid_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "asana_asana_families", "asana_families"
  add_foreign_key "asana_asana_families", "asanas"
  add_foreign_key "asana_names", "asanas"
  add_foreign_key "courses", "places"
  add_foreign_key "courses", "styles"
  add_foreign_key "lessons", "styles"
  add_foreign_key "subscriptions", "users"
end
