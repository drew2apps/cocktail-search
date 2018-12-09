class RecipesController < ApplicationController
  def index
    recipes = Cocktail::SearchCocktails.new(query: query).call
    render json: { message: 'Retrieved recipes', data: recipes }, status: :ok
  end

  private

  def query
    params.fetch(:query, "")
  end
end