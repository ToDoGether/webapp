Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # As suggested in devise installation after running 'rails generate devise:install'
  # NOTE: Ensure you have defined root_url to *something* in your config/routes.rb.
  #       For example:
  root to: "home#index"
end
