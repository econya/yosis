# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

Rails.application.routes.draw do
  root to: 'pages#home'

  get 'about_us',    to: 'pages#about_us'
  get 'privacy',     to: 'pages#privacy'
  get 'terms',       to: 'pages#terms'
  get 'impressum',   to: 'pages#impressum'
  get 'explanation', to: 'pages#explanation'

  devise_for :users

  resources :users, only: [:index], controller: 'admin/users' do
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
  end

  resources :courses, only: [:index, :show]
  resources :customers
  resources :courses, only: [:index, :show]
  namespace :admin do
    resources :courses, only: [:index, :edit, :update, :destroy, :new, :create] do
      resources :lessons, controller: 'course/lessons'
      resource :position, only: [:create, :destroy], controller: 'course/position'
    end
    resources :appointments
    resources :site_settings, only: [:index, :show, :edit, :update]
    resources :users, only: [:index, :show] do
      resources :subscriptions, only: [:edit, :update, :create, :destroy, :new], controller: 'user/subscriptions'
    end
  end
end
