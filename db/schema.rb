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

ActiveRecord::Schema[7.1].define(version: 2024_02_02_113630) do
  create_table "deep_l_glossaries", force: :cascade do |t|
    t.string "glossary_id"
    t.string "name"
    t.integer "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_deep_l_glossaries_on_language_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terms", force: :cascade do |t|
    t.string "original"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "translated_term"
    t.integer "term_id", null: false
    t.integer "language_id", null: false
    t.index ["language_id"], name: "index_translations_on_language_id"
    t.index ["term_id", "language_id"], name: "index_translations_on_term_id_and_language_id", unique: true
    t.index ["term_id"], name: "index_translations_on_term_id"
  end

  add_foreign_key "translations", "languages"
  add_foreign_key "translations", "terms"
end
