Rails.application.routes.draw do
  root to: "home#home"
  resources :borrower_projects, only: [:new, :create]

  resources :projects, only: [:index, :show, :update]
  resources :categories, only: [:index, :show], param: :slug
  resources :cart_projects, only: [:create, :update, :destroy]
  resources :cart, only: [:index]
  resources :users, only: [:new, :create, :update, :edit]
  get "/lender_dashboard", to: "users#lender_dashboard"
  get "/borrower_dashboard", to: "users#borrower_dashboard"
  resources :lenders, only: [:new], param: :slug
  resources :borrowers, only: [:new], param: :slug
  get '/login', to: "session#new"
  post '/login', to: "session#create"
  delete '/logout', to: "session#destroy"
  post '/checkout', to: "loans#create"
  put '/become_borrower', to: "users#become_borrower"
  put '/become_lender', to: "users#become_lender"

  namespace :admin do
    resources :dashboard, only: [:index, :show]
    resources :projects, only: [:update]
  end

  namespace :users, path: ":user", as: :user do
    resources :projects, only: [:show]
    resources :cart_projects, only: [:create, :new]
  end
  get '*unmatched_route', to: 'application#not_found'
end
