Rails.application.routes.draw do
  get 'seession/new'
  root "static_pages#home"
  get "/help",to:"static_pages#help"
  
  get '/signup',to:"users#new"
  get '/login',to:"sessions#new"
  post '/login',to:"sessions#create"
  delete '/logout',to:"sessions#destroy"
  
  resources :users do
    member do
      get 'edit_name'
      get 'edit_email'
      get 'edit_password'
    end
  end
  
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
