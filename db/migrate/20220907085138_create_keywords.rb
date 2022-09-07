class CreateKeywords < ActiveRecord::Migration[7.0]
  def change
    create_table :keywords do |t|
      t.string :name
      t.string :variations

      t.timestamps
    end

    add_index :keywords, :name

    create_join_table :experiments, :keywords
  end
end
