Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show, :edit, :update] do
  end
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users do
      member do
        get :change_admin
      end
    end
    resources :tasks, only: [:index]
  end
end
