class CreateTransactions < ActiveRecord::Migration[8.0]
  def up
    create_table :transactions do |t|
      t.references :user, null: false, comment: "User reference"
      t.references :category, null: false, comment: "Category reference"
      t.integer :transaction_type, null: false, comment: "Transaction type"
      t.string :description, comment: "Description of income"
      t.integer :amount, null: false, comment: "Total amount of income"
      t.datetime :transacted_at, null: false
      t.timestamps
    end
  end

  def down
    drop_table :transactions
  end
end
