Rails.application.routes.draw do
  devise_for :users

  root to: 'projects#index'
  get '/uikit', to: 'pages#uikit'
  get '/sitemap', to: 'pages#sitemap'
<<<<<<< HEAD
=======
  get '/profiles/edit', to: 'profiles#edit', as: 'edit_profile'
  patch '/profiles', to: 'profiles#update', as: 'update_profile'
>>>>>>> a19f2a1bdfbc7a6b6c46ada33d3f9e3c2f3db209
  resources :profiles, only: [:index, :show]
  resources :projects, only: [:index, :show, :new, :create] do
    resources :jobs, only: [:new, :create]
  end
<<<<<<< HEAD
  get '/profiles/edit', to: 'profiles#edit'
  patch '/profiles', to: 'profiles#update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
# users/:id/profiles
=======
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
>>>>>>> a19f2a1bdfbc7a6b6c46ada33d3f9e3c2f3db209
