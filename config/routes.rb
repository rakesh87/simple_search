Rails.application.routes.draw do

  root to: 'categories#index'

  get 'log_out' => "sessions#destroy", as: :log_out
  get 'log_in' => "sessions#new", as: :log_in
  get 'sign_up' => "users#new", as: :sign_up

  resources :users

  resources :sessions, only: [:new, :create, :destroy]

  resources :categories do
    collection do
      get :autofill_data
    end
  end

end
