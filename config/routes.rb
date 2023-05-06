Rails.application.routes.draw do
  get 'current_users/show'
  get 'current_users/edit'
  devise_for :users,skip: [:passwords]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "current_users#show"
  
  resources :current_users, only:[:show,:edit,:update]
  resources :users,only:[:show]
  resources :jobs
end
