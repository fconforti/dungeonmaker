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

ActiveRecord::Schema[7.0].define(version: 2024_03_30_153626) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_abilities_on_name", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

  create_table "character_abilities", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "character_id", null: false
    t.bigint "ability_id", null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ability_id"], name: "index_character_abilities_on_ability_id"
    t.index ["account_id"], name: "index_character_abilities_on_account_id"
    t.index ["character_id"], name: "index_character_abilities_on_character_id"
  end

  create_table "character_positions", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "character_id", null: false
    t.bigint "dungeon_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_character_positions_on_account_id"
    t.index ["character_id"], name: "index_character_positions_on_character_id"
    t.index ["dungeon_id"], name: "index_character_positions_on_dungeon_id"
    t.index ["room_id"], name: "index_character_positions_on_room_id"
  end

  create_table "characters", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "race_id", null: false
    t.bigint "klass_id", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "hp", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_characters_on_account_id"
    t.index ["klass_id"], name: "index_characters_on_klass_id"
    t.index ["name"], name: "index_characters_on_name", unique: true
    t.index ["race_id"], name: "index_characters_on_race_id"
  end

  create_table "dungeons", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_dungeons_on_account_id"
    t.index ["name"], name: "index_dungeons_on_name", unique: true
  end

  create_table "exit_obstacles", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "dungeon_id", null: false
    t.bigint "exit_id", null: false
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_exit_obstacles_on_account_id"
    t.index ["dungeon_id"], name: "index_exit_obstacles_on_dungeon_id"
    t.index ["exit_id"], name: "index_exit_obstacles_on_exit_id"
    t.index ["item_type", "item_id"], name: "index_exit_obstacles_on_item"
    t.index ["name", "exit_id"], name: "index_exit_obstacles_on_name_and_exit_id", unique: true
  end

  create_table "exits", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "dungeon_id", null: false
    t.bigint "from_room_id", null: false
    t.bigint "to_room_id", null: false
    t.string "direction", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_exits_on_account_id"
    t.index ["dungeon_id"], name: "index_exits_on_dungeon_id"
    t.index ["from_room_id"], name: "index_exits_on_from_room_id"
    t.index ["name", "from_room_id"], name: "index_exits_on_name_and_from_room_id", unique: true
    t.index ["to_room_id"], name: "index_exits_on_to_room_id"
  end

  create_table "keys", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "dungeon_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_keys_on_account_id"
    t.index ["dungeon_id"], name: "index_keys_on_dungeon_id"
    t.index ["name", "dungeon_id"], name: "index_keys_on_name_and_dungeon_id", unique: true
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
    t.bigint "account_id", null: false
    t.bigint "dungeon_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_rooms_on_account_id"
    t.index ["dungeon_id"], name: "index_rooms_on_dungeon_id"
    t.index ["name", "dungeon_id"], name: "index_rooms_on_name_and_dungeon_id", unique: true
  end

  add_foreign_key "character_abilities", "abilities"
  add_foreign_key "character_abilities", "accounts"
  add_foreign_key "character_abilities", "characters"
  add_foreign_key "character_positions", "accounts"
  add_foreign_key "character_positions", "characters"
  add_foreign_key "character_positions", "dungeons"
  add_foreign_key "character_positions", "rooms"
  add_foreign_key "characters", "accounts"
  add_foreign_key "characters", "klasses"
  add_foreign_key "characters", "races"
  add_foreign_key "dungeons", "accounts"
  add_foreign_key "exit_obstacles", "accounts"
  add_foreign_key "exit_obstacles", "dungeons"
  add_foreign_key "exit_obstacles", "exits"
  add_foreign_key "exits", "accounts"
  add_foreign_key "exits", "dungeons"
  add_foreign_key "exits", "rooms", column: "from_room_id"
  add_foreign_key "exits", "rooms", column: "to_room_id"
  add_foreign_key "keys", "accounts"
  add_foreign_key "keys", "dungeons"
  add_foreign_key "klass_abilities", "abilities"
  add_foreign_key "klass_abilities", "klasses"
  add_foreign_key "race_abilities", "abilities"
  add_foreign_key "race_abilities", "races"
  add_foreign_key "rooms", "accounts"
  add_foreign_key "rooms", "dungeons"
end
