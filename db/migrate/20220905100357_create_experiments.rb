class CreateExperiments < ActiveRecord::Migration[7.0]
  def change
    create_table :experiments do |t|
      t.column :name, :string, null: false
      t.column :title, :text
      t.column :external_id, :integer
      t.column :pao_summary, :text
      t.column :research_summary, :text
      t.column :research_description, :text
      t.column :research_operations, :text
      t.column :applications_in_space, :text
      t.column :applications_on_earth, :text
      t.column :results, :text
      t.column :results_summary, :text
      t.column :res_ops_reqs_protos, :text
      t.column :hardware_payload, :text
      t.column :nanoracks, :text
      t.column :dock_date, :datetime
      t.column :undock_date, :datetime
      t.column :results_publications_count, :integer, default: 0
      t.column :link_text, :string
      t.column :link_url, :string

      t.belongs_to :category
      t.belongs_to :subcategory
      t.belongs_to :space_agency
      t.belongs_to :organization

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
