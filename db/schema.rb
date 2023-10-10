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

ActiveRecord::Schema[7.1].define(version: 2023_10_10_104550) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "developers", force: :cascade do |t|
    t.bigint "external_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "developers_experiments", id: false, force: :cascade do |t|
    t.bigint "experiment_id", null: false
    t.bigint "developer_id", null: false
  end

  create_table "expeditions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expeditions_experiments", id: false, force: :cascade do |t|
    t.bigint "experiment_id", null: false
    t.bigint "expedition_id", null: false
  end

  create_table "experiments", force: :cascade do |t|
    t.string "name", null: false
    t.text "title"
    t.integer "external_id"
    t.text "pao_summary"
    t.text "research_summary"
    t.text "research_description"
    t.text "research_operations"
    t.text "applications_in_space"
    t.text "applications_on_earth"
    t.text "results"
    t.text "results_summary"
    t.text "res_ops_reqs_protos"
    t.text "hardware_payload"
    t.text "nanoracks"
    t.datetime "dock_date"
    t.datetime "undock_date"
    t.integer "results_publications_count", default: 0
    t.string "link_text"
    t.string "link_url"
    t.bigint "category_id"
    t.bigint "subcategory_id"
    t.bigint "space_agency_id"
    t.bigint "organization_id"
    t.boolean "required_sample_return"
    t.integer "sample_return_times", default: 0
    t.boolean "crew_involvement"
    t.text "crew_involvement_description"
    t.boolean "data_in_repositories"
    t.text "data_in_respositories_details"
    t.boolean "completed_successfully"
    t.text "hardware_required_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "revised", default: false
    t.boolean "hardware_required", default: false
    t.boolean "commercial", default: false
    t.text "decadals"
    t.index ["category_id"], name: "index_experiments_on_category_id"
    t.index ["external_id"], name: "index_experiments_on_external_id"
    t.index ["name"], name: "index_experiments_on_name"
    t.index ["organization_id"], name: "index_experiments_on_organization_id"
    t.index ["space_agency_id"], name: "index_experiments_on_space_agency_id"
    t.index ["subcategory_id"], name: "index_experiments_on_subcategory_id"
  end

  create_table "experiments_investigators", id: false, force: :cascade do |t|
    t.bigint "experiment_id", null: false
    t.bigint "investigator_id", null: false
  end

  create_table "experiments_keywords", id: false, force: :cascade do |t|
    t.bigint "experiment_id", null: false
    t.bigint "keyword_id", null: false
  end

  create_table "investigators", force: :cascade do |t|
    t.bigint "external_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string "name"
    t.string "variations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_keywords_on_name"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "space_agencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
