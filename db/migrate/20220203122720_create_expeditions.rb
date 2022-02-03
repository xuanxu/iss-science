class CreateExpeditions < ActiveRecord::Migration[7.0]
  def change
    create_table :expeditions do |t|
      t.string :name

      t.timestamps
    end
  end
end
