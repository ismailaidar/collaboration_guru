Rails.application.routes.draw do
  resources :projects
  get 'pages/index'
  devise_for :users
  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'pages#index'
end
