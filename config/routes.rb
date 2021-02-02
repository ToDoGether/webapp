Rails.application.routes.draw do
  resources :teams
  resources :tasks
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # As suggested in devise installation after running 'rails generate devise:install'
  # NOTE: Ensure you have defined root_url to *something* in your config/routes.rb.
  #       For example:
  root to: 'tasks#index'

  get '/subscribe', action: :subscribe, controller: 'teams'
  get '/unsubscribe/:id', action: :unsubscribe, controller: 'teams'
  get '/change_status/:id/:direction', action: :change_status, controller: 'tasks'

  get '/filter/', action: :filter, controller: 'tasks'

end
