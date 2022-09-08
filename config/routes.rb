Rails.application.routes.draw do
  resources :experiments, only: [:index, :show, :update]

  resources :investigators, only: [:index, :show]
  resources :developers, only: [:index, :show]
  resources :expeditions, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :subcategories, only: [:index, :show]
  resources :space_agencies, only: [:index, :show]
  resources :organizations, only: [:index, :show]
  resources :keywords

  root "experiments#index"
end
