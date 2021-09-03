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

ActiveRecord::Schema.define(version: 2021_08_30_013625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
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

  create_table "andinists", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "club"
    t.string "gender"
    t.text "img_url"
    t.string "img_author"
    t.string "fullname"
    t.string "club_to_s"
    t.string "country_to_s"
    t.integer "remarkable_ascents"
    t.integer "first_absolutes"
    t.integer "first_ascents"
  end

  create_table "andinists_articles", id: false, force: :cascade do |t|
    t.bigint "andinist_id", null: false
    t.bigint "article_id", null: false
    t.index ["andinist_id"], name: "index_andinists_articles_on_andinist_id"
    t.index ["article_id"], name: "index_andinists_articles_on_article_id"
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

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "subtitle"
    t.string "img_url"
    t.string "img_author"
  end

  create_table "ascents", force: :cascade do |t|
    t.integer "year"
    t.integer "month"
    t.integer "day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "route_id", null: false
    t.string "name"
    t.boolean "first_absolute"
    t.boolean "first_ascent"
    t.string "mountain_name"
    t.string "route_name"
    t.string "andinists_to_s"
    t.string "fulldate"
    t.string "fulldate_for_form"
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
    t.string "ancestry"
    t.text "img_url"
    t.string "img_author"
    t.boolean "unregistered_non_sport_ascent"
    t.boolean "unregistered_sport_ascent"
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
    t.boolean "unregistered_non_sport_ascent"
    t.boolean "unregistered_sport_ascent"
    t.index ["mountain_id"], name: "index_routes_on_mountain_id"
  end

  create_table "sectors", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "img_url"
    t.string "description"
    t.string "img_author"
  end

  create_table "sources", force: :cascade do |t|
    t.text "name"
    t.text "link"
    t.string "referenceable_type"
    t.bigint "referenceable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["referenceable_type", "referenceable_id"], name: "index_sources_on_referenceable_type_and_referenceable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "superadmin_role", default: false
    t.boolean "supervisor_role", default: false
    t.boolean "user_role", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ascents", "routes"
  add_foreign_key "nomenclatura_objects", "igm_rectangles"
  add_foreign_key "nomenclatura_objects", "mountains"
  add_foreign_key "routes", "mountains"
end
