Rails.application.routes.draw do
  root to: "homes#about"

  devise_for :users,
    skip: [:passwords, :registrations], #いらないルーティングを作らない。sessionとregistration新規のみ。
    controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get "users/sign_up" => "devise/registrations#new", as: "new_user_registration"
   post "users" => "devise/registrations#create", as: "user_registration"
  end

  resources :users, only:[:show, :edit, :update], param: :account_name #ランダム文字列をidの代わりに使用

  get "jobs/search" => "jobs#search", as: "job_search"
  get "jobs/draft_index" => "jobs#draft_index", as: "job_draft_index"
  resources :jobs, only:[:show, :new, :create, :edit, :update, :destroy], param: :rondom_id #ランダム文字列をidの代わりに使用

  resource :bookmarks, only:[:create,:destroy]
  get "bookmarks/index" => "bookmarks#index", as: "bookmark_index"
  #resourceだとindexアクションが生成されないため自作。"bookmarks_path"を使おうとするとエラーになるため名前も自作。

  resource :offers, only:[:create,:destroy]
  get "offers/index" => "offers#index", as: "offers_index"
  #resourceだとindexアクションが生成されないため自作。"offers_paths"を使おうとするとエラーになるため名前も自作。

  resources :chatrooms, only:[:index, :show, :create, :destroy], param: :rondom_id do
    get "change_hide" => "chatrooms#change_hide", as: "change_hide"
  end#ランダム文字列をidの代わりに使用
  resources :messages,only:[:create]
end
