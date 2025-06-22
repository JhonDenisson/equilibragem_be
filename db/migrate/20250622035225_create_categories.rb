class CreateCategories < ActiveRecord::Migration[8.0]
  def up
    create_table :categories do |t|
      t.references :user, foreign_key: true, null: true, comment: "User reference"
      t.string :name, null: false, comment: "Category name"
      t.integer :category_type, null: false, comment: "Category type"
      t.timestamps
    end
  end

  def down
    drop_table :categories
  end
end
