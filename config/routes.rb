Rails.application.routes.draw do
  root 'home#index'

  get :signup, to: 'users#new'
  get :login, to: 'sessions#new'
  get :logout, to: 'sessions#destroy'

  resources :users, path: 'newuser', only: :create
  resources :sessions, path: 'login', only: :create

  resources :tests do
    member do
      post 'start'
    end
    resources :questions, shallow: true, except: [:index]
    resources :results, path: 'dotest', shallow: true, only: %i[show update] do
      member do
        get 'result', as: 'completed'
      end
    end
  end
end
