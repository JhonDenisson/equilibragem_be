class CreateSummaries < ActiveRecord::Migration[8.0]
  def change
    create_table :summaries do |t|
      t.references :user, foreign_key: true, null: true, comment: "User reference"
      t.integer :total_income
      t.integer :total_expense
      t.integer :fixed_expense
      t.integer :balance
      t.text :allocations
      t.timestamps
    end
  end
end
