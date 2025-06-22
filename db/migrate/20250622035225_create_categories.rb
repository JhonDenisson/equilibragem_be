class CreateCategories < ActiveRecord::Migration[8.0]
  def up
    create_table :categories do |t|
      t.string :name, null: false, comment: "Category name"
      t.integer :category_type, null: false, comment: "Category type"
      t.references :user, null: false, comment: "User reference"
      t.timestamps
    end
  end

  def down
    drop_table :categories
  end
end
