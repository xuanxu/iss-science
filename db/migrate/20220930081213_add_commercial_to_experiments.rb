class AddCommercialToExperiments < ActiveRecord::Migration[7.0]
  def change
    add_column :experiments, :commercial, :boolean, default: false
  end
end
