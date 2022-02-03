class CreateExperimentsHasManyAssociations < ActiveRecord::Migration[7.0]
  def change
    create_join_table :experiments, :principal_investigators
    create_join_table :experiments, :developers
    create_join_table :experiments, :expeditions
  end
end
