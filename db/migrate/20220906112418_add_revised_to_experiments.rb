class AddRevisedToExperiments < ActiveRecord::Migration[7.0]
  def change
    add_column :experiments, :revised, :boolean, default: false
  end
end
