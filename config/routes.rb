Rails.application.routes.draw do
  
  root 'users#index'
  resources :users, :tasks
  get "/signout" => "users#delete"
  get "/auth/:provider/callback" => "users#connect"
  post "/login" => "users#login", as: "login"
  resources :tasks do
    member do
       get :stop
       put :stop
    end 
  end
end
