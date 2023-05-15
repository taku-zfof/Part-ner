Rails.application.routes.draw do
  root to: "homes#about"
  
  devise_for :users,skip: [:passwords, :registrations] #いらないルーティングを作らない。sessionとregistration新規のみ。
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get "users/sign_up" => "devise/registrations#new", as: "new_user_registration"
   post "users" => "devise/registrations#create", as: "user_registration"
  end
  
  resources :users, only:[:show, :edit, :update], param: :account_name
  
  get "jobs/search" => "jobs#search", as: "job_search"
  get "jobs/draft_index" => "jobs#draft_index", as: "job_draft_index"
  resources :jobs

  resource :bookmarks, only:[:create,:destroy]
  get "bookmarks/index" => "bookmarks#index", as: "bookmark_index"
  #resourceだとindexアクションが生成されないため自作。"bookmarks_path"を使おうとするとエラーになるため名前も自作。

  resource :offers, only:[:create,:destroy]
  get "offers/index" => "offers#index", as: "offers_index"
  get "offers/send_index" => "offers#send_index", as: "offers_send_index"
  #resourceだとindexアクションが生成されないため自作。"offers_paths"を使おうとするとエラーになるため名前も自作。
  
  resources :chatrooms, only:[:index, :show, :create, :destroy]
  resources :messages,only:[:create]
end
