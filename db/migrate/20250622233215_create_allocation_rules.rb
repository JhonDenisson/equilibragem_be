class CreateAllocationRules < ActiveRecord::Migration[8.0]
  def up
    create_table :allocation_rules do |t|
      t.references :user, foreign_key: true, null: false, comment: "User reference"
      t.references :category, foreign_key: true, null: false, comment: "Category reference"
      t.integer :percentage, default: 0, null: false
      t.timestamps
    end
    add_index :allocation_rules, [:user_id, :category_id], unique: true
  end

  def down
    drop_table :allocation_rules
  end
end
