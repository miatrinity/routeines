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

ActiveRecord::Schema.define(version: 2020_04_13_184858) do

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

  create_table "flow_steps", force: :cascade do |t|
    t.integer "routine_flow_id", null: false
    t.integer "step_id", null: false
    t.string "time_to_complete", default: "0"
    t.integer "status", default: 0
    t.index ["routine_flow_id"], name: "index_flow_steps_on_routine_flow_id"
    t.index ["step_id"], name: "index_flow_steps_on_step_id"
  end

  create_table "routine_flows", force: :cascade do |t|
    t.integer "status", default: 0
    t.string "time_to_complete"
    t.integer "routine_id", null: false
    t.datetime "completed_at"
    t.datetime "started_at"
    t.index ["routine_id"], name: "index_routine_flows_on_routine_id"
  end

  create_table "routines", force: :cascade do |t|
    t.string "title"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_routines_on_user_id"
  end

  create_table "steps", force: :cascade do |t|
    t.string "title"
    t.boolean "first", default: false
    t.integer "next_id"
    t.integer "routine_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["next_id"], name: "index_steps_on_next_id"
    t.index ["routine_id"], name: "index_steps_on_routine_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "flow_steps", "routine_flows"
  add_foreign_key "flow_steps", "steps", on_delete: :cascade
  add_foreign_key "routine_flows", "routines"
  add_foreign_key "routines", "users"
  add_foreign_key "steps", "routines"
end
