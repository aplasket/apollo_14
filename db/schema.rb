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

ActiveRecord::Schema[7.0].define(version: 2018_09_04_152506) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "astronaut_missions", force: :cascade do |t|
    t.bigint "astronaut_id"
    t.bigint "mission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["astronaut_id"], name: "index_astronaut_missions_on_astronaut_id"
    t.index ["mission_id"], name: "index_astronaut_missions_on_mission_id"
  end

  create_table "astronauts", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "job"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "missions", force: :cascade do |t|
    t.string "title"
    t.integer "time_in_space"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "astronaut_missions", "astronauts"
  add_foreign_key "astronaut_missions", "missions"
end
