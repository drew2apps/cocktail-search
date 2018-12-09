require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  it 'returns a JSON array of recipes that are results of the query passed in' do
    get :index, params: {query: "whiskey"}, as: :json
    expect(response.response_code).to eq(200)
    parsed_body = JSON.parse(response.body)
    expect(parsed_body["data"].count).to eq(1)
    expect(parsed_body["message"]).to eq("Retrieved recipes")
  end

  it 'returns a JSON array of recipes with 25 results when no query is passed in' do
    get :index, params: {}, as: :json
    expect(response.response_code).to eq(200)
    parsed_body = JSON.parse(response.body)
    expect(parsed_body["data"].count).to eq(25)
    expect(parsed_body["message"]).to eq("Retrieved recipes")
  end

  it 'returns a JSON array of ordered recipes by title when a query and order is passed in' do
    get :index, params: {query: "apple", order: "title"}, as: :json
    expect(response.response_code).to eq(200)
    parsed_body = JSON.parse(response.body)
    expect(parsed_body["data"].first["title"] <=> parsed_body["data"].last["title"]).to eq(-1)
  end

  it 'returns a JSON array of ordered recipes by id when a query and invalid order is passed in' do
    get :index, params: {query: "apple", order: "foo"}, as: :json
    expect(response.response_code).to eq(200)
    parsed_body = JSON.parse(response.body)
    expect(parsed_body["data"].first["id"]).to be < parsed_body["data"].last["id"]
  end

  it 'returns a JSON result of a recipe when searching for a record in the database' do
    recipe = create(:recipe)
    get :show, params: {id: recipe.id}, as: :json
    expect(response.response_code).to eq(200)
    parsed_body = JSON.parse(response.body)
    expect(parsed_body["message"]).to eq("Retrieved recipe")
    expect(parsed_body["data"]["title"]).to eq(recipe.title)
  end

  it 'returns a JSON result of not found when searching for a record not in the database' do
    get :show, params: {id: 1}, as: :json
    expect(response.response_code).to eq(404)
    parsed_body = JSON.parse(response.body)
    expect(parsed_body["message"]).to eq("Could not find recipe")
  end

  it 'returns a JSON result of not found when searching for an invalid record not in the database' do
    get :show, params: {id: "FOO"}, as: :json
    expect(response.response_code).to eq(404)
    parsed_body = JSON.parse(response.body)
    expect(parsed_body["message"]).to eq("Could not find recipe")
  end
end