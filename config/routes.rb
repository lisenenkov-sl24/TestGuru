Rails.application.routes.draw do
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
