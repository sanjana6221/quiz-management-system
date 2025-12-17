Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  namespace :admin do
    resource :session, only: [:new, :create, :destroy]
    get "/login", to: "sessions#new", as: :login
    delete "/logout", to: "sessions#destroy", as: :logout

    get "/", to: "quizzes#index", as: :root
    
    # Quiz Management
    resources :quizzes do
      resources :questions, except: [:index, :show] do
        resources :options, except: [:index, :show]
      end
    end
  end

  # Public routes
  root "quizzes#index"
  resources :quizzes, only: [:index, :show] do
    resources :submissions, only: [:create]
  end
  resources :submissions, only: [:show]
end
