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

ActiveRecord::Schema[7.0].define(version: 2023_07_12_050343) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ava_admin_users", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["email"], name: "index_ava_admin_users_on_email", unique: true
  end

  create_table "clinic_members", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "password_digest", null: false
    t.string "type", null: false
    t.boolean "active_member", default: true
    t.boolean "admin", default: false
    t.integer "clinic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["clinic_id"], name: "index_clinic_members_on_clinic_id"
    t.index ["email"], name: "index_clinic_members_on_email", unique: true
  end

  create_table "clinics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "csv_files", force: :cascade do |t|
    t.integer "migration_id"
    t.integer "number_of_columns"
    t.string "preview_rows"
    t.integer "number_of_rows"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["migration_id"], name: "index_csv_files_on_migration_id"
  end

  create_table "import_cells", force: :cascade do |t|
    t.integer "import_header_id"
    t.integer "import_row_id", null: false
    t.integer "migration_id", null: false
    t.string "raw_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["import_header_id"], name: "index_import_cells_on_import_header_id"
    t.index ["import_row_id"], name: "index_import_cells_on_import_row_id"
    t.index ["migration_id"], name: "index_import_cells_on_migration_id"
  end

  create_table "import_header_matchers", force: :cascade do |t|
    t.string "parsed_csv_header"
    t.integer "import_header_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["import_header_id"], name: "index_import_header_matchers_on_import_header_id"
  end

  create_table "import_headers", force: :cascade do |t|
    t.string "patient_attribute"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "import_rows", force: :cascade do |t|
    t.integer "migration_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "migration_status", default: 0
    t.boolean "conflicts_with_existing_patient", default: false
    t.boolean "invalid_data", default: false
    t.integer "patient_id"
    t.string "warnings", default: "{}"
    t.index ["conflicts_with_existing_patient"], name: "index_import_rows_on_conflicts_with_existing_patient"
    t.index ["invalid_data"], name: "index_import_rows_on_invalid_data"
    t.index ["migration_id"], name: "index_import_rows_on_migration_id"
    t.index ["patient_id"], name: "index_import_rows_on_patient_id"
  end

  create_table "migrations", force: :cascade do |t|
    t.integer "performance_statistics"
    t.text "description"
    t.integer "clinic_id", null: false
    t.integer "clinic_member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "import_headers_order"
    t.text "notes"
    t.index ["clinic_id"], name: "index_migrations_on_clinic_id"
    t.index ["clinic_member_id"], name: "index_migrations_on_clinic_member_id"
  end

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
    t.date "date_of_birth"
    t.string "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "clinic_id", null: false
    t.integer "patient_replaced_by_id"
    t.index ["clinic_id", "health_identifier_number", "health_identifier_province"], name: "index_patients_on_clinic_h_identifier_number_and_province", unique: true
    t.index ["clinic_id"], name: "index_patients_on_clinic_id"
    t.index ["email"], name: "index_patients_on_email"
    t.index ["patient_replaced_by_id"], name: "index_patients_on_patient_replaced_by_id"
    t.index ["phone"], name: "index_patients_on_phone"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clinic_members", "clinics"
  add_foreign_key "csv_files", "migrations"
  add_foreign_key "import_cells", "import_headers"
  add_foreign_key "import_cells", "import_rows"
  add_foreign_key "import_cells", "migrations"
  add_foreign_key "import_header_matchers", "import_headers"
  add_foreign_key "import_rows", "migrations"
  add_foreign_key "import_rows", "patients"
  add_foreign_key "migrations", "clinic_members"
  add_foreign_key "migrations", "clinics"
  add_foreign_key "patients", "clinics"
  add_foreign_key "patients", "patients", column: "patient_replaced_by_id"
end
