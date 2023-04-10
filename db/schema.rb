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

ActiveRecord::Schema[7.0].define(version: 2023_04_10_205416) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_authors_on_name", unique: true
  end

  create_table "licenses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_licenses_on_name", unique: true
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.string "md5"
    t.string "maintainer"
    t.string "dependencies"
    t.datetime "publication_date"
    t.string "version"
    t.bigint "license_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["license_id"], name: "index_packages_on_license_id"
  end

  create_table "packages_authors", id: false, force: :cascade do |t|
    t.bigint "package_id"
    t.bigint "author_id"
    t.index ["author_id"], name: "index_packages_authors_on_author_id"
    t.index ["package_id"], name: "index_packages_authors_on_package_id"
  end

  add_foreign_key "packages", "licenses"
end
