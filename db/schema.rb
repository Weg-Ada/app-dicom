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

ActiveRecord::Schema.define(version: 2018_11_02_133243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "examinations", force: :cascade do |t|
    t.string "name", null: false
    t.string "path", null: false
    t.datetime "examinated_at"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_examinations_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name", null: false
    t.string "login", null: false
    t.string "password_digest"
    t.boolean "is_admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "examinations", "patients", on_update: :cascade, on_delete: :cascade
end
