Rails.application.routes.draw do

  root "static_pages#home"
  get "login"     => "sessions#new"
  post "login"    => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "help"      =>  "static_pages#help"
  get "about"     =>  "static_pages#about"
  get "contact"   =>  "static_pages#contact"
  get "signup"    =>  "users#new"
  
  namespace :admin do
    root "dashboards#home"
    resources :users, only: [:index, :destroy]
    resources :categories do
      resources :words
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :users, except: :destroy
  resources :categories, only: :index
  resources :lessons, only: :create
  match "/users/:id/:type", to: "relationships#index", via: :get

  resources :categories, only: :index do
    resources :lessons
    resources :words
  end
  resources :lessons do
    resources :lesson_words
  end

end
