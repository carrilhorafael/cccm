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

ActiveRecord::Schema.define(version: 2022_04_21_181556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "churches", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.boolean "is_head", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "filters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "source"
    t.string "sortable", default: "system_access"
    t.json "restriction", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_filters_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ministery_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ministery_id"], name: "index_memberships_on_ministery_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "ministeries", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "church_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["church_id"], name: "index_ministeries_on_church_id"
  end

  create_table "proselytes", force: :cascade do |t|
    t.string "name"
    t.date "proselytized_at"
    t.string "phone"
    t.bigint "church_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["church_id"], name: "index_proselytes_on_church_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "phone"
    t.string "title"
    t.boolean "is_leader", default: false
    t.datetime "last_time_logged_at"
    t.boolean "president_pastor", default: false
    t.string "validation_token"
    t.datetime "validation_token_sent_at"
    t.datetime "access_garantied_at"
    t.string "access_garantied_by"
    t.bigint "church_id"
    t.date "birthdate"
    t.integer "marital_status"
    t.string "location"
    t.date "member_since"
    t.boolean "is_baptized", default: false
    t.integer "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "notes"
    t.index ["church_id"], name: "index_users_on_church_id"
  end

  add_foreign_key "filters", "users"
  add_foreign_key "memberships", "ministeries"
  add_foreign_key "memberships", "users"
  add_foreign_key "ministeries", "churches"
  add_foreign_key "proselytes", "churches"
  add_foreign_key "users", "churches"
end
