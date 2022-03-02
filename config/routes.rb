Rails.application.routes.draw do
  put "/users/:id/grant_access", to: "users#grant_access"
  get '/ministeries/:id/memberships', to: "ministeries#memberships"
  post '/ministeries/:id/memberships', to: "ministeries#create_membership"
  resources :churches do
    resources :users, only: [:index, :create]
    resources :ministeries, only: [:index, :create]
  end
  get '/validate_user', to: "application#validate_user"
  post "/auth/login"
  post "/auth/reset"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
