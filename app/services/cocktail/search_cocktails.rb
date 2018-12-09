module Cocktail
  class SearchCocktails < Base
    attr_accessor :query

    def initialize(args = {})
      super(args)
      self.query = args[:query]
    end

    def call
      search = Search.find_or_initialize_by(query: query)
      search.id.nil? ? search(search) : search.recipes
    end

    def search(search)
      response = Request.get("search.php?s=#{search.query}")
      recipe_ids = []
      response["drinks"].each do |drink|
        recipe = update_recipe(drink)
        recipe_ids << recipe.id if recipe
        search.recipes << recipe unless search.recipes.exists?(recipe.id)
      end if response["drinks"]

      search.save
      Recipe.where(id: recipe_ids)
    end
  end
end