Rails.application.routes.draw do
  root to: "home#home"
  resources :projects, only: [:index, :show, :update]
  resources :categories, only: [:index, :show], param: :slug
  resources :cart_projects, only: [:create, :update, :index, :destroy]
  resources :cart, only: [:index]
  resources :users, only: [:new, :create, :update]

  get "/lender_dashboard", to: "users#lender_dashboard"
  get "/borrower_dashboard", to: "users#borrower_dashboard"

  resources :lenders, only: [:new, :index, :show], param: :slug
  # get '/lenders-dashboard', to: "lenders#dashboard"
  resources :borrowers, only: [:new, :index, :show], param: :slug
  # get '/borrowers-dashboard', to: "borrowers#dashboard"

  get '/login', to: "session#new"
  post '/login', to: "session#create"
  delete '/logout', to: "session#destroy"
  put '/dashboard', to: "users#update"
  post '/checkout', to: "orders#create"

  namespace :admin do
    resources :dashboard, only: [:index, :show], param: :status
    resources :orders, only: [:update]
    resources :stickers, only: [:new, :create, :index, :edit, :update]
  end

  namespace :users, path: ":user", as: :user do
    resources :projects, only: [:show]
    resources :cart_projects, only: [:create, :new]
  end

  get '*unmatched_route', to: 'application#not_found'
end
