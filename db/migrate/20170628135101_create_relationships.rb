class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.text :name
      t.integer :influence_id
      t.integer :influenced_id
      t.string :type
      t.text :description

      t.timestamps null: false
    end
  end
end
