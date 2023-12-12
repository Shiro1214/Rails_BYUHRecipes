Rails.application.routes.draw do
  get 'addFavorite' => "favorites#create"
  get 'removeFavorite' => "favorites#destroy"
  get 'favorites' => "favorites#index"
  get 'login' => "sessions#new"
  get "logout" => "sessions#destroy"
  get "signup" => "users#new"
  get "auth/:provider/callback" => "authentications#create"
  resources :users, except: [:index, :new]
  resources :sessions, except: [:index, :new, :update, :show, :new, :destroy]
  resources :recipes do 
      resources :comments, except: [:index]
      resources :favorites, only: [:index,:create, :destroy]
  end
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "about" => "sites#about" #call about method from sites route
  # Defines the root path route ("/")
   root "sites#index"
end
