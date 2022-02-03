Rails.application.routes.draw do
  resources :experiments, only: [:index, :show, :edit, :update]

  resources :principal_investigators, only: [:index, :show]
  resources :developers, only: [:index, :show]
  resources :expeditions, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :space_agencies, only: [:index, :show]

  root "experiments#index"
end
