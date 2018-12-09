module Cocktail
  class SearchCocktails < Base
    attr_accessor :query,
                  :clear_cache

    def initialize(args = {})
      super(args)
      self.query = args[:query]
      self.clear_cache = args[:clear_cache]
    end

    def call
      cache = CACHE_DEFAULTS.merge({ force: clear_cache })
      search = Search.find_or_initialize_by(query: query)
      search.id.nil? ? search(search, cache)  : search.recipes
    end

    def search(search, cache)
      response = Request.get("search.php?s=#{search.query}", cache)
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