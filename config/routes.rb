Rails.application.routes.draw do
  devise_for :users,skip: [:passwords]
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#about"

  resources :users,only:[:show, :edit, :update]
  get "jobs/search" => "jobs#search", as: "job_search"
  resources :jobs
 
  resource :bookmarks, only:[:create,:destroy]
  get "bookmarks/index" => "bookmarks#index", as: "bookmark_index"

end
