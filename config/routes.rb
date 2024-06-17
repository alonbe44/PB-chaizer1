
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users #cover all crud
  resources :locations
  resources :stations
  resources :warehouses
  resources :power_banks
  root 'users#index'
end
