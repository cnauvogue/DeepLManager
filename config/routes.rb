Rails.application.routes.draw do
  resources :terms do
    collection do
      get :submit
    end
  end
  resources :languages
  resources :translations, except: [:index]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "terms#index"
end
