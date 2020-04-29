# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

Rails.application.routes.draw do
  root to: 'pages#home'

  get '/up', to: proc {[200, {}, ['is_up']]}

  get 'about-us',    to: 'pages#about_us'
  get 'privacy',     to: 'pages#privacy'
  get 'terms',       to: 'pages#terms'
  get 'impressum',   to: 'pages#impressum'
  get 'explanation', to: 'pages#explanation'

  devise_for :users, controllers: {
    registrations: 'registrations',
    confirmations: 'confirmations',
    invitations: 'invitations' }

  resources :users, only: [:index], controller: 'admin/users' do
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
  end

  resource :contacts, only: [:new, :create]

  resources :courses, only: [:index, :show]

  namespace :admin do
    resources :appointments

    resources :courses, only: [:index, :edit, :update, :destroy, :new, :create] do
      resources :lessons, controller: 'course/lessons' do
        resource :position, only: [:create, :destroy], controller: 'course/lesson/position'
      end
      resource :position, only: [:create, :destroy], controller: 'course/position'
    end

    resources :delayed_jobs, only: [:index, :show, :destroy] do
      resource :execution, only: [:create], controller: 'delayed_jobs/execution'
    end

    resources :emails, only: [:index, :show]

    resources :site_settings, only: [:index, :show, :edit, :update]

    resources :users, only: [:index, :show, :destroy] do
      resources :subscriptions, only: [:edit, :update, :create, :destroy, :new], controller: 'user/subscriptions'
    end
  end
end
