Rails.application.routes.draw do
  root "sessions#new"
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :doctors, only: [:show]
  resources :patients, only: [:index, :show]
  resources :migrations, only: [:index, :new, :create, :show, :update]
  resources :import_rows, only: [:edit, :update]

  # namespace :admin do
  #   get 'login', to: 'sessions#new'
  #   post 'login', to: 'sessions#create'
  #   delete 'logout', to: 'sessions#destroy'
  # end
end
