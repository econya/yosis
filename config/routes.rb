Rails.application.routes.draw do
  devise_for :users
  resources :courses, only: [:index, :show]
  root to: 'pages#home'
  resources :customers
  namespace :admin do
    resources :site_settings, only: [:index, :edit, :update]
  end
end
