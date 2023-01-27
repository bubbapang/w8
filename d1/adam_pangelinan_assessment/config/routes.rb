Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:new, :create, :index, :show] do
    resources :notes, only: [:create, :edit, :update]
  end

  resource :session, only: [:new, :create, :destroy]
end