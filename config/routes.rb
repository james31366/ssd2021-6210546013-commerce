Rails.application.routes.draw do

  devise_for :admins
  root 'admin/products#index'

  resources :home
  namespace :admin do
    namespace :products do
      post 'csv_upload'
    end
    resources :products do
      member do
        delete 'delete_image_attachment'
      end
    end
    resources :categories
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
