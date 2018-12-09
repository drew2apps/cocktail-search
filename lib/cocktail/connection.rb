require 'faraday'
require 'json'

class Connection
  def self.api
    Faraday.new(url: 'https://www.thecocktaildb.com/api/json/v1/1/') do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['X-Cocktail-Key'] = Rails.configuration.cocktail_key
    end
  end
end