require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CocktailSearch
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.autoload_paths += %W(#{config.root}/lib/cocktail)
    config.autoload_paths += %W(#{config.root}/app/services)

    config.cocktail_key = ENV['COCKTAIL_KEY']

    #Since the list of cocktail recipes returned from the server is small, we'll use 2 as a limit for testing an as an example for pagination
    config.default_result_limit_min = 2
    config.default_result_limit_max = 50

    #If the column name to order the results is not found, default to id
    config.default_result_order = "id"

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
