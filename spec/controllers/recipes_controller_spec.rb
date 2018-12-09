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