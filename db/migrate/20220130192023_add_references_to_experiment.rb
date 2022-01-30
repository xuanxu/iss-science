class AddReferencesToExperiment < ActiveRecord::Migration[7.0]
  def change
    add_reference :experiments, :category
    add_reference :experiments, :space_agency
    remove_column :experiments, :category
    remove_column :experiments, :sponsoring_space_agency
  end
end
