Pyc::Application.routes.draw do
  resources :images, except: [:new]

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  get 'tags/:tag', to: 'images#index', as: :tag
end
