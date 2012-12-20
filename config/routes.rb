VitalySampleApp2ndEd::Application.routes.draw do
    
  get "password_resets/new"

  get "pasword_reset/new"

  root to: 'static_pages#home'

  resources :users do
     member do
        get :following, :followers
     end
  end

  resources :sessions, only: [:new, :create, :destroy] 
  resources :microposts, only: [:index, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  match '/signup',          to: 'users#new'
  match '/signin',          to: 'sessions#new'
  match '/signout',         to: 'sessions#destroy', via: :delete
  match '/help',            to: 'static_pages#help'
  match '/about',           to: 'static_pages#about'
  match '/contact',         to: 'static_pages#contact'
  match 'activations/:id',  to: 'activations#update', as: :activation, via: :get

end
