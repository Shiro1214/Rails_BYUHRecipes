class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :recipe_id
      t.integer :user_id

      t.timestamps
    end
  end
end
