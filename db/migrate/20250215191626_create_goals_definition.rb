class CreateGoalsDefinition < ActiveRecord::Migration[8.0]
  def change
    create_table :goals_definition do |t|
      t.string :name
      t.string :description
      t.boolean :default
      t.integer :user_id, null: false
      t.index [ :user_id ], name: "index_goals_definition_on_user_id"
      t.timestamps
    end
  end
end
