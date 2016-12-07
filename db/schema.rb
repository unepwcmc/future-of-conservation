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

ActiveRecord::Schema.define(version: 20161207111942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_sets", force: :cascade do |t|
    t.string   "ip_address"
    t.jsonb    "answers"
    t.float    "x_axis_total"
    t.float    "y_axis_total"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "uuid"
    t.float    "x_axis_scaled"
    t.float    "y_axis_scaled"
    t.integer  "classification_id"
    t.index ["classification_id"], name: "index_answer_sets_on_classification_id", using: :btree
  end

  create_table "classifications", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "results_description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "demographic_questions", force: :cascade do |t|
    t.text     "text"
    t.integer  "position"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "text"
    t.float    "x_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "y_weight"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

end
