Imgx::Application.routes.draw do
  resources :images

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end