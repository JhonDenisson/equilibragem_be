class CreateSummaries < ActiveRecord::Migration[8.0]
  def up
    create_table :summaries do |t|
      t.references :user, foreign_key: true, null: false, comment: "User reference"
      t.integer :month, null: false
      t.integer :year, null: false
      t.decimal :total_income, precision: 10, scale: 2, default: 0
      t.decimal :total_expense, precision: 10, scale: 2, default: 0
      t.decimal :balance, precision: 10, scale: 2, default: 0
      t.timestamps
    end
    add_index :summaries, [:user_id, :month, :year], unique: true
  end

  def down
    drop_table :summaries
  end
end
