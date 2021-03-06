Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'seession/new'
  root "static_pages#home"
  get "/help",to:"static_pages#help"
  
  get '/signup',to:"users#new"
  get '/login',to:"sessions#new"
  post '/login',to:"sessions#create"
  delete '/logout',to:"sessions#destroy"
  
  # memberはゆーざーIDが含まれているurlを扱うようになる.collectionｈどうだろうか
  resources :users do
    member do    
      get 'edit_name'
      get 'edit_email'
      get 'edit_password'
      get :following, :followers
    end
  end
  resources :notes, only:[:create,:destroy,:new,:edit,:update]
  resources :relationships, only:[:create,:destroy]
  resources :likes, only:[:create,:destroy]
end
  
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

