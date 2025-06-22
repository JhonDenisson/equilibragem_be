class CreateIncomes < ActiveRecord::Migration[8.0]
  def up
    create_table :incomes do |t|
      t.references :user, null: false, comment: "User reference"
      t.references :categories, null: false, comment: "Category reference"
      t.string :description, comment: "Description of income"
      t.integer :amount, null: false, comment: "Total amount of income"
      t.timestamps
    end
  end

  def down
    drop_table :incomes
  end
end
