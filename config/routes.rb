Rails.application.routes.draw do

  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  get "users/index" => "users#index"
  get "users/:id" => "users#show"
  get "users/:id/edit" => "users#edit"

  post "users/create" => "users#create"
  post "users/:id/update" => "users#update"
  post "users/:id/destroy" => "users#destroy"


  get "posts/index" => "posts#index"
  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"


  post "posts/create" => "posts#create"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"


  get "/" => "home#top"
  get "signup" => "users#new"


  get "admin" => "admin#index"
  get "admin/posts/index" => "admin/posts#index"
  post "admin/posts/:id/update" => "admin/posts#update"
  post "admin/posts/:id/destroy" => "admin/posts#destroy"

  get "admin/users/index" => "admin/users#index"
  post "admin/users/:id/update" => "admin/users#update"
  post "admin/users/:id/destroy" => "admin/users#destroy"

  namespace :admin do
    resources :users
    resources :posts
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
