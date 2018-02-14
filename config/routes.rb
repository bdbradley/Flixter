Rails.application.routes.draw do
  devise_for :users
  #Shows the index.html.erb view from the static_pages controller 
  root 'static_pages#index'
  resources :courses, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :instructor do
    resources :courses, only: [:new, :create, :show]
  end
end