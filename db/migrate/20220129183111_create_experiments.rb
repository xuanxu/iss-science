class CreateExperiments < ActiveRecord::Migration[7.0]
  def change
    create_table :experiments do |t|
      t.column :short_name, :string, null: false
      t.column :full_name, :text
      t.column :principal_investigators_raw, :text
      t.column :developers_raw, :text
      t.column :expeditions_raw, :string
      t.column :category, :string
      t.column :sponsoring_space_agency, :string
      t.column :required_sample_return, :boolean
      t.column :sample_return_times, :integer, default: 0
      t.column :crew_involvement, :boolean
      t.column :crew_involvement_description, :text
      t.column :data_in_repositories, :boolean
      t.column :data_in_respositories_details, :text
      t.column :completed_successfully, :boolean
      t.column :hardware_required, :string
      t.column :hardware_required_details, :text
      t.timestamps
    end
  end
end

