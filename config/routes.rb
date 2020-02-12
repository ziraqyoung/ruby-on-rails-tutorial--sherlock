Rails.application.routes.draw do
  root to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :edit, :create, :update]
end
