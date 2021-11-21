Rails.application.routes.draw do
  get '/validate_user', to: "application#validate_user"
  post "/auth/login", to: "auth#login"
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
