Rails.application.routes.draw do
  get 'categories/index'
  devise_for :admins
  root "products#index"

  resources :products
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
