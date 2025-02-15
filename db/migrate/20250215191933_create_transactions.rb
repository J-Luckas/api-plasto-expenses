class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :description
      t.string :transaction_type
      t.float :value
      t.integer :goal_definition_id, null: false
      t.index [ :goal_definition_id ], name: "index_transactions_on_goal_definition_id"
      t.timestamps
    end
  end
end
