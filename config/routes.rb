Rails.application.routes.draw do
  devise_for :users

  root to: 'projects#index'
  get '/uikit', to: 'pages#uikit'
  get '/sitemap', to: 'pages#sitemap'
  resources :profiles, only: [:index, :show]
  resources :projects, only: [:index, :show, :new, :create] do
    resources :jobs, only: [:new, :create]
  end
  get '/profiles/edit', to: 'profiles#edit'
  patch '/profiles', to: 'profiles#update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
# users/:id/profiles
