class CreateExperimentsHasManyAssociations < ActiveRecord::Migration[7.0]
  def change
    create_join_table :experiments, :categories
    create_join_table :experiments, :developers
    create_join_table :experiments, :principal_investigators
  end
end
