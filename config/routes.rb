Rails.application.routes.draw do
  devise_for :users

  root to: 'projects#index'

  resources :pages

  resources :profiles, only: [:index, :show, :create, :edit, :update]

  resources :projects do
    resources :jobs, only: [:index, :new, :create, :edit, :update]
  end

  resources :jobs, only: [:show, :destroy] do
    resources :user_jobs, only: [:show, :new, :create, :edit, :update]
  end

  resources :user_jobs, only: [:index]

  resources :signatures, only: :create

  get '/overview', to: 'projects#overview'

  get '/auth/:provider/callback', to: 'ds_common#create_session'

  get '/ds/mustAuthenticate' => 'ds_common#ds_must_authenticate'

  # get '/uikit', to: 'pages#uikit'
  # get '/sitemap', to: 'pages#sitemap'
  # get '/profiles/edit', to: 'profiles#edit', as: 'edit_profile'
  # post '/profiles', to: 'profiles#update', as: 'create_profile'
  # patch '/profiles/:id', to: 'profiles#update', as: 'update_profile'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
