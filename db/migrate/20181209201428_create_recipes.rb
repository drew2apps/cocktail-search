class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :cocktail_id
      t.string :title
      t.string :glass
      t.string :thumbnail
      t.string :alcoholic
      t.text :instructions
      t.json :ingredients
      t.timestamps
    end
  end
end
