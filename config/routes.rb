Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  devise_for :users,skip: [:passwords]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  
  resources :users, only:[:show,:edit,]
  resources :jobs
end
