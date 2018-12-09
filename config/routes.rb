Rails.application.routes.draw do
  resources :recipes, only: %w(show index)
end
