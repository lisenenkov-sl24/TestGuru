Rails.application.routes.draw do
  devise_for :users, path_names: {
    sign_in: 'login', sign_out: 'logout'
  }

  root 'home#index'

  resources :tests, only: %i[index] do
    member do
      post 'start'
    end
    resources :results, path: 'passage', shallow: true, only: %i[index show update] do
      member do
        get 'result', as: 'completed'
      end
    end
  end

  namespace :admin do
    root 'home#index'
    resources :tests do
      resources :questions, shallow: true, except: [:index]
    end
    resources :users, only: %i[index] do
      member do
        post 'make_admin'
        delete 'make_admin', action: :delete_admin
      end
    end
  end
end
