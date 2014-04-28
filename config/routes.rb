Pyc::Application.routes.draw do
  root to: "images#index"

  resources :images, except: [:new] do
    member do
      get :download
    end
  end

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users, only: [:show] do
    member do
      get :statistics
    end
  end

  resources :comments, only: [:create]
  get '/tags/:tag', to: 'images#index', as: :tag

  # Redirect all unknown paths to root
  # This must remain at the bottom
  get '*path' => redirect('/')
end
