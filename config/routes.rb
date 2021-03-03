# frozen_string_literal: true

Rails.application.routes.draw do
  resources :teams
  resources :tasks
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # As suggested in devise installation after running 'rails generate devise:install'
  # NOTE: Ensure you have defined root_url to *something* in your config/routes.rb.
  #       For example:
  root to: 'tasks#index'

  get '/subscribe', to: 'teams#subscribe'
  get '/unsubscribe/:id', to: 'teams#unsubscribe'
  get '/change_status/:id/:direction', to: 'tasks#change_status'

  get '/filter', to: 'tasks#filter'
  get '/filter-reset', to: 'tasks#reset_filter'
  get '/filter-apply', to: 'tasks#apply_filter'

  get '/calendar', to: 'tasks#calendar'
  get '/exams', to: 'tasks#exams'
end
