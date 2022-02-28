Rails.application.routes.draw do
  resources :users, except: :create
  resources :churches do
    resources :users, only: :create
    resources :ministeries
  end
  get '/validate_user', to: "application#validate_user"
  post "/auth/login"
  post "/auth/reset"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
