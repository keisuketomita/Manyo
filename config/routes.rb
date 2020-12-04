Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :assigns, only: [:create, :destroy]
  resources :teams
  resources :labels
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks do
    member do
      get :download
    end
    collection do
      get :calender
    end
  end
  namespace :admin do
    resources :users do
      member do
        get :change_admin
      end
    end
    resources :tasks, only: [:index]
  end
end
