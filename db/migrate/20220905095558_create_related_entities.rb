class CreateRelatedEntities < ActiveRecord::Migration[7.0]
  def change
    create_table :space_agencies do |t|
      t.string :name
      t.timestamps
    end

    create_table :organizations do |t|
      t.string :name
      t.timestamps
    end

    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :subcategories do |t|
      t.string :name
      t.timestamps
    end

    create_table :expeditions do |t|
      t.string :name
      t.timestamps
    end

    create_table :investigators do |t|
      t.bigint :external_id
      t.string :name
      t.timestamps
    end

    create_table :developers do |t|
      t.bigint :external_id
      t.string :name
      t.timestamps
    end
  end
end
