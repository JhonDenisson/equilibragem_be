class CreateSummaries < ActiveRecord::Migration[8.0]
  def up
    create_table :summaries do |t|
      t.references :user, foreign_key: true, null: false, comment: "User reference"
      t.integer :month, null: false
      t.integer :year, null: false
      t.integer :total_income, null: false
      t.integer :total_expense, null: false
      t.integer :balance, null: false
      t.timestamps
    end
    add_index :summaries, [:user_id, :month, :year], unique: true
  end

  def down
    drop_table :summaries
  end
end
