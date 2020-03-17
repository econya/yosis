Rails.application.routes.draw do
  devise_for :users
  resources :courses
  root to: 'pages#home'
  resources :customers
end
