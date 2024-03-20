Rails.application.routes.draw do
  resources :projects
  get 'users/fetch_users', to: 'users#fetch_users'
  get 'pages/index'
  devise_for :users
  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'pages#index'

  get 'users/search', to: 'users#search'
end
