class AddIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index :experiments, :external_id
    add_index :experiments, :name
  end
end
