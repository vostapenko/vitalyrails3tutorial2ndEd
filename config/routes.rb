VitalySampleApp2ndEd::Application.routes.draw do

  scope "(:locale)", :locale => /en|ru/ do
    resources :users

    root to: 'static_pages#home'

    match '/signup',  to: 'users#new'
    match '/help',    to: 'static_pages#help'
    match '/about',   to: 'static_pages#about'
    match '/contact', to: 'static_pages#contact'
  end
end
