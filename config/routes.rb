Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'merchants#index'

  resources :merchants, only: [:index, :show, :edit, :update, :destroy]

  resources :transactions, only: [:index]

  mount API::Base, at: '/api'
end
