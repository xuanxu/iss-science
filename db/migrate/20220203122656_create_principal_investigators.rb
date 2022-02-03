class CreatePrincipalInvestigators < ActiveRecord::Migration[7.0]
  def change
    create_table :principal_investigators do |t|
      t.string :name

      t.timestamps
    end
  end
end
