Rails.application.routes.draw do
  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Admin namespace
  namespace :admin do
    # Authentication
    resource :session, only: [:new, :create, :destroy]
    get "login", to: "sessions#new", as: :login
    delete "logout", to: "sessions#destroy", as: :logout

    root "quizzes#index"

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
