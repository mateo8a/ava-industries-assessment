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

ActiveRecord::Schema[7.0].define(version: 2023_07_09_034240) do
  create_table "patients", force: :cascade do |t|
    t.integer "health_identifier_number"
    t.string "health_identifier_province"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.integer "phone"
    t.string "email"
    t.string "address_one"
    t.string "address_two"
    t.string "address_province"
    t.string "address_city"
    t.string "address_postal_code"
    t.date "birthday"
    t.string "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_patients_on_email"
    t.index ["health_identifier_number", "health_identifier_province"], name: "index_patients_on_health_identifier_number_and_province", unique: true
    t.index ["phone"], name: "index_patients_on_phone"
  end

end
