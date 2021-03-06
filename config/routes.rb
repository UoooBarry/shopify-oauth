Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :home
  resources :users
  resources :sessions
  delete 'logout', to: 'sessions#destroy'
  get 'shopify/oauth', to: 'shopify#index'
  get 'shopify/oauth/authorize', to: 'shopify#authorize'
  post 'shopify/oauth/confirm', to: 'shopify#confirm'
end
