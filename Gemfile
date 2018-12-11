source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails', '5.2.1'
gem 'puma', '~> 3.11'

gem 'bootsnap', '>= 1.1.0', require: false

gem 'dotenv-rails'
gem 'faraday'
gem 'mysql2', '0.5.2'
gem 'activerecord-import', '0.27.0'

#Testing Gems
group :development, :test do
  gem 'rb-readline'
  gem 'rspec-rails', '3.8.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
end

group :production do
  gem 'pg'
end
