# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

Rails.application.routes.draw do
  devise_for :users
  resources :courses, only: [:index, :show]
  root to: 'pages#home'
  resources :customers
  resources :courses, only: [:index, :show]
  namespace :admin do
    resources :courses, only: [:index, :edit, :update, :destroy, :new, :create] do
    end
    resources :appointments
    resources :site_settings, only: [:index, :edit, :update]
  end
end
