class RecipesController < ApplicationController
  def show
    recipe = Recipe.find_by(id: params[:id])
    if recipe
      render json: { message: 'Retrieved recipe', data: recipe }, status: :ok
    else
      render json: { message: 'Could not find recipe' }, status: :not_found
    end
  end

  def index
    begin
      ActiveRecord::Base.transaction do
        recipes = Cocktail::SearchCocktails.new(query: query,
                                                clear_cache: clear_cache).call

        render json: { message: 'Retrieved recipes', data: recipes }, status: :ok
      end
    rescue => e
      render json: { message: 'An error occurred while performing your search. Please try again.' }, status: :bad_request
    end
  end

  private

  def query
    params.fetch(:query, "")
  end

  def clear_cache
    params[:clear_cache].present?
  end
end