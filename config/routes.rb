Rails.application.routes.draw do
  devise_for :users

  root to: 'projects#index'
  get '/uikit', to: 'pages#uikit'
  get '/sitemap', to: 'pages#sitemap'
  get '/profiles/edit', to: 'profiles#edit', as: 'edit_profile'
  post '/profiles', to: 'profiles#update', as: 'create_profile'
  patch '/profiles/:id', to: 'profiles#update', as: 'update_profile'
  get '/overview', to: 'projects#overview'
  resources :profiles, only: [:index, :show]
  resources :projects, only: [:index, :show, :new, :create] do
    resources :jobs, only: [:index, :new, :create]
  end
  resources :user_jobs, only: [:index]
  resources :jobs, only: [:show] do
    resources :user_jobs, only: [:new, :create, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
