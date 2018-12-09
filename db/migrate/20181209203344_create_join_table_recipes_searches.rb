class CreateJoinTableRecipesSearches < ActiveRecord::Migration[5.2]
  def change
    create_join_table :recipes, :searches do |t|
      t.index [:recipe_id, :search_id]
      t.index [:search_id, :recipe_id]
    end
  end
end

