Rails.application.routes.draw do
  resources :labels
  resources :users
  root to: "tasks#index"
  post '/', to: 'tasks#index'
  resources :tasks
  get '/sessions/new', to: 'sessions#new', as: 'new_session'
  post '/sessions/new' , to: 'sessions#create', as: 'create_session'
  get '/sessions/destroy' , to: 'sessions#destroy', as: 'destroy_session'

  namespace :admin do
    resources :users
  end
  delete '/admin/users/:id', to: 'admin/users#destroy', as: 'admin_user_delete'
  put '/admin/users/:id', to: 'admin/users#update', as: 'admin_user_update'

  get 'admin/users/do-admin/:id', to: 'admin/users#do_admin', as: 'admin_user_do_admin'
  get 'admin/users/not-do-admin/:id', to: 'admin/users#not_do_admin', as: 'admin_user_not_do_admin'
end
