class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :imgUrl
      t.integer :servingSize
      t.decimal :budget
      t.integer :prepTime
      t.integer :cookTime
      t.text :ingredients
      t.string :storesAvailable
      t.text :cookingDirection
      t.integer :user_id

      t.timestamps
    end
  end
end
