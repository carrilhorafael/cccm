Rails.application.routes.draw do
  resources :users, except: [:index, :create] do
    put "grant_access", to: "users#grant_access"
    put "revoke_access", to: "users#revoke_access"
    post "ministeries", to: "users#add_ministeries"
    delete "ministeries", to: "users#remove_ministery"
  end
  resources :churches do
    resources :users, only: [:index, :create]
    resources :ministeries, only: [:index, :create]
  end
  get '/validate_user', to: "application#validate_user"
  post "/auth/login"
  post "/auth/reset"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
