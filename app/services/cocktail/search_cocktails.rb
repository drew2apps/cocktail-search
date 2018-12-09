module Cocktail
  class SearchCocktails < Base
    attr_accessor :query,
                  :order,
                  :filter_search,
                  :filter_type,
                  :clear_cache

    def initialize(args = {})
      super(args)
      self.query = args[:query]
      self.order = args[:order]
      self.filter_search = args[:filter_search]
      self.filter_type = args[:filter_type]
      self.clear_cache = args[:clear_cache]
    end

    def call
      cache = CACHE_DEFAULTS.merge({ force: clear_cache })
      search = Search.find_or_initialize_by(query: query)
      search.id.nil? ? search(search, cache)  : organize_results(search.recipes, order, filter_search, filter_type)
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
      organize_results(Recipe.where(id: recipe_ids), order, filter_search, filter_type)
    end
  end
end