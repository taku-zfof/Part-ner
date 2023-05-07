Rails.application.routes.draw do
  get 'jobs/new'
  get 'jobs/show'
  get 'jobs/edit'
  get 'jobs/index'
  devise_for :users,skip: [:passwords]
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"

  resources :users,only:[:show, :edit, :update]
  resources :jobs
end
