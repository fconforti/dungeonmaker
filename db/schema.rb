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

ActiveRecord::Schema[7.0].define(version: 2023_05_03_201515) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_abilities_on_name", unique: true
  end

  create_table "character_abilities", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "ability_id", null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ability_id"], name: "index_character_abilities_on_ability_id"
    t.index ["character_id"], name: "index_character_abilities_on_character_id"
  end

  create_table "characters", force: :cascade do |t|
    t.bigint "race_id", null: false
    t.bigint "klass_id", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "hp", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_characters_on_klass_id"
    t.index ["name"], name: "index_characters_on_name", unique: true
    t.index ["race_id"], name: "index_characters_on_race_id"
  end

  create_table "dungeons", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_dungeons_on_name", unique: true
  end

  create_table "klass_abilities", force: :cascade do |t|
    t.bigint "klass_id", null: false
    t.bigint "ability_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ability_id"], name: "index_klass_abilities_on_ability_id"
    t.index ["klass_id"], name: "index_klass_abilities_on_klass_id"
  end

  create_table "klasses", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hit_die", null: false
    t.index ["name"], name: "index_klasses_on_name", unique: true
  end

  create_table "race_abilities", force: :cascade do |t|
    t.bigint "race_id", null: false
    t.bigint "ability_id", null: false
    t.integer "score_increase", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ability_id"], name: "index_race_abilities_on_ability_id"
    t.index ["race_id"], name: "index_race_abilities_on_race_id"
  end

  create_table "races", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_races_on_name", unique: true
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "dungeon_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dungeon_id"], name: "index_rooms_on_dungeon_id"
    t.index ["name"], name: "index_rooms_on_name", unique: true
  end

  add_foreign_key "character_abilities", "abilities"
  add_foreign_key "character_abilities", "characters"
  add_foreign_key "characters", "klasses"
  add_foreign_key "characters", "races"
  add_foreign_key "klass_abilities", "abilities"
  add_foreign_key "klass_abilities", "klasses"
  add_foreign_key "race_abilities", "abilities"
  add_foreign_key "race_abilities", "races"
  add_foreign_key "rooms", "dungeons"
end
