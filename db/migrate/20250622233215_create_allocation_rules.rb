class CreateAllocationRules < ActiveRecord::Migration[8.0]
  def change
    create_table :allocation_rules do |t|
      t.references :user, foreign_key: true, null: true, comment: "User reference"
      t.references :category, foreign_key: true, null: true, comment: "Category reference"
      t.integer :percentage, default: 0, null: false
      t.timestamps
    end
  end
end
