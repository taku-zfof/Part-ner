Rails.application.routes.draw do
  devise_for :users,skip: [:passwords]
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "current_users#show"
  
  resources :current_users, only:[:show,:edit,:update]
  resources :users,only:[:show]
  resources :jobs
end
