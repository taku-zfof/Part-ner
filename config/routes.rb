Rails.application.routes.draw do
  devise_for :users,skip: [:passwords]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "users#show"
  
  resources :users, only:[:show,:edit,:update]
  resources :jobs
end
