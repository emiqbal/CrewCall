Rails.application.routes.draw do
  devise_for :users
  resources :profiles, except: [:destroy]
  resources :projects, only: [:index, :show, :new, :create] do
    resources :jobs, only: [:new, :create]
  end
  resources :jobs, only: [:show]
  root to: 'projects#index'
  get '/uikit', to: 'pages#uikit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# users/:id/profiles
