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

ActiveRecord::Schema[7.0].define(version: 2022_09_30_085142) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

end
