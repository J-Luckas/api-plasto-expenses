class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.float :spend_by_day
      t.timestamps
    end

  end
end
