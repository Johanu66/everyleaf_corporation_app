Rails.application.routes.draw do
  root to: "tasks#index"
  post '/', to: 'tasks#index'
  resources :tasks
end
