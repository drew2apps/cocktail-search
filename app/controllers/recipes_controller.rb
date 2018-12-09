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
                                                order: order,
                                                clear_cache: clear_cache,
                                                filter_search: filter_search,
                                                filter_type: filter_type).call

        render json: { message: 'Retrieved recipes', data: recipes }, status: :ok
      end
    rescue => e
      render json: { message: 'An error occurred while performing your search. Please try again.' }, status: :bad_request
    end
  end

  private

  def order
    #If the column name to order the results is not found, default to id
    temp_order = params.fetch(:order, "id")
    Recipe.column_names.include?(temp_order) ? temp_order : "id"
  end

  def query
    params.fetch(:query, "")
  end

  def filter_type
    filter_type = params.fetch(:filter_type, "")
    Recipe.column_names.include?(filter_type) ? filter_type : ""
  end

  def filter_search
    params.fetch(:filter_search, "")
  end

  def clear_cache
    params[:clear_cache].present?
  end
end