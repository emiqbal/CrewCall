Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  devise_for :users
  root to: 'projects#index'
  get '/uikit', to: 'pages#uikit'
  resources :projects, only: [:index, :show, :new, :create]
  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
