class CreateBudgets < ActiveRecord::Migration[8.0]
  def up
    create_table :budgets do |t|
      t.references :user, null: false, comment: "User reference"
      t.references :category, null: false, comment: "Category reference"
      t.integer :percent, null: false, comment: "percentage of the remaining balance that will be allocated to the budget"
      t.integer :value_cents, null: false, comment: "Value cents of the budget"
      t.timestamps
    end
  end

  def down
    drop_table :budgets
  end
end
