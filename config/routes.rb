Rails.application.routes.draw do
  devise_for :users
  root to: 'projects#index'
  get '/uikit', to: 'pages#uikit'
  resources :profiles, only: [:index, :show, :new, :create, :edit, :update]
  resources :projects, only: [:index, :show, :new, :create] do
    resources :jobs, only: [:show, :new, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
