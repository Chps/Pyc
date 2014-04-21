Pyc::Application.routes.draw do
  resources :images, except: [:new]

  root to: "images#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users, except: [:edit]
  get 'tags/:tag', to: 'images#index', as: :tag

  # Redirect all unknown paths to root
  # This must remain at the bottom
  get '*path' => redirect('/')
end
