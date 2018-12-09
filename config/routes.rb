Rails.application.routes.draw do
  resources :recipes, only: %w(index)
end
