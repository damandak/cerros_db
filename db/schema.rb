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

ActiveRecord::Schema.define(version: 2021_05_23_153136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "andinists", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "club"
    t.string "gender"
  end

  create_table "andinists_ascents", id: false, force: :cascade do |t|
    t.bigint "andinist_id", null: false
    t.bigint "ascent_id", null: false
    t.index ["andinist_id"], name: "index_andinists_ascents_on_andinist_id"
    t.index ["ascent_id"], name: "index_andinists_ascents_on_ascent_id"
  end

  create_table "andinists_clubs", force: :cascade do |t|
    t.bigint "andinist_id"
    t.bigint "club_id"
    t.index ["andinist_id"], name: "index_andinists_clubs_on_andinist_id"
    t.index ["club_id"], name: "index_andinists_clubs_on_club_id"
  end

  create_table "andinists_countries", force: :cascade do |t|
    t.bigint "country_id"
    t.bigint "andinist_id"
    t.index ["andinist_id"], name: "index_andinists_countries_on_andinist_id"
    t.index ["country_id"], name: "index_andinists_countries_on_country_id"
  end

  create_table "ascents", force: :cascade do |t|
    t.integer "year"
    t.integer "month"
    t.integer "day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "route_id", null: false
    t.string "name"
    t.index ["route_id"], name: "index_ascents_on_route_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries_mountains", force: :cascade do |t|
    t.bigint "country_id"
    t.bigint "mountain_id"
    t.index ["country_id"], name: "index_countries_mountains_on_country_id"
    t.index ["mountain_id"], name: "index_countries_mountains_on_mountain_id"
  end

  create_table "igm_rectangles", force: :cascade do |t|
    t.string "name"
    t.string "file_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mountains", force: :cascade do |t|
    t.string "name"
    t.string "prefix"
    t.integer "altitude"
    t.string "nom_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "ahb_id"
    t.string "ahb"
    t.string "alternative_name_prefix"
    t.string "alternative_name"
    t.integer "secondary_altitude"
    t.string "secondary_altitude_name"
    t.boolean "previously_ascended"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "mountains_sectors", force: :cascade do |t|
    t.bigint "mountain_id"
    t.bigint "sector_id"
    t.index ["mountain_id"], name: "index_mountains_sectors_on_mountain_id"
    t.index ["sector_id"], name: "index_mountains_sectors_on_sector_id"
  end

  create_table "nomenclatura_objects", force: :cascade do |t|
    t.string "nom_id"
    t.string "revision_code"
    t.string "name"
    t.integer "altitude_igm"
    t.string "latitude_south"
    t.string "longitude_west"
    t.string "observations"
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "igm_rectangle_id", null: false
    t.bigint "mountain_id", null: false
    t.index ["igm_rectangle_id"], name: "index_nomenclatura_objects_on_igm_rectangle_id"
    t.index ["mountain_id"], name: "index_nomenclatura_objects_on_mountain_id"
  end

  create_table "routes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "mountain_id", null: false
    t.index ["mountain_id"], name: "index_routes_on_mountain_id"
  end

  create_table "sectors", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "img_url"
    t.string "description"
  end

  add_foreign_key "ascents", "routes"
  add_foreign_key "nomenclatura_objects", "igm_rectangles"
  add_foreign_key "nomenclatura_objects", "mountains"
  add_foreign_key "routes", "mountains"
end
