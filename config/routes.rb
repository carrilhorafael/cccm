Rails.application.routes.draw do
  resources :ministeries, only: [:destroy, :update]
  resources :filters, only: [:update, :create]
  resources :users, except: [:index, :create] do
    get 'member_card', to: 'cards#member_card'
  end
  resources :churches do
    get 'resume'
    resources :proselytes, only: [:index, :create]
    resources :users, only: [:index, :create]
    resources :ministeries, only: [:index, :create]
  end
  get '/validate_user', to: "application#validate_user"
  post "/auth/login"
  post "/auth/reset"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
