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

ActiveRecord::Schema.define(version: 2022_02_03_123113) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "developers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "developers_experiments", id: false, force: :cascade do |t|
    t.integer "experiment_id", null: false
    t.integer "developer_id", null: false
  end

  create_table "expeditions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "expeditions_experiments", id: false, force: :cascade do |t|
    t.integer "experiment_id", null: false
    t.integer "expedition_id", null: false
  end

  create_table "experiments", force: :cascade do |t|
    t.string "short_name", null: false
    t.text "full_name"
    t.text "principal_investigators_raw"
    t.text "developers_raw"
    t.string "expeditions_raw"
    t.boolean "required_sample_return"
    t.integer "sample_return_times", default: 0
    t.boolean "crew_involvement"
    t.text "crew_involvement_description"
    t.boolean "data_in_repositories"
    t.text "data_in_respositories_details"
    t.boolean "completed_successfully"
    t.string "hardware_required"
    t.text "hardware_required_details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category_id"
    t.integer "space_agency_id"
    t.index ["category_id"], name: "index_experiments_on_category_id"
    t.index ["space_agency_id"], name: "index_experiments_on_space_agency_id"
  end

  create_table "experiments_principal_investigators", id: false, force: :cascade do |t|
    t.integer "experiment_id", null: false
    t.integer "principal_investigator_id", null: false
  end

  create_table "principal_investigators", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "space_agencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
