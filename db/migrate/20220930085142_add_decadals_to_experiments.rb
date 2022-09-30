class AddDecadalsToExperiments < ActiveRecord::Migration[7.0]
  def change
    add_column :experiments, :decadals, :text, default: nil
  end
end
