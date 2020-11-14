Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show, :edit, :update] do
  end
  resources :sessions, only: [:new, :create, :destroy]
end
