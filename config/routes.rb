Rails.application.routes.draw do

  #-- 会員認証 --#
  devise_for :clients,
    path: '',
    path_names: { sign_in: 'login', sign_out: 'logout'},
    controllers: { 
      sessions: 'client/clients/sessions',
      passwords: 'client/clients/passwords',
      registrations: 'client/clients/registrations',
      confirmations: 'client/clients/confirmations',
      omniauth_callbacks: 'client/clients/omniauth_callbacks'
    }

  #-- 専門家認証 --#
  devise_for :experts, skip: :all
  devise_scope :expert do
    get 'expert/login' => 'expert/experts/sessions#new', as: :new_expert_session
    post 'expert/login' => 'expert/experts/sessions#create', as: :expert_session
    delete 'expert/logout' => 'expert/experts/sessions#destroy', as: :destroy_expert_session
  end

  #-- 管理者認証 --#
  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admin/login' => 'admin/admins/sessions#new', as: :new_admin_session
    post 'admin/login' => 'admin/admins/sessions#create', as: :admin_session
    delete 'admin/logout' => 'admin/admins/sessions#destroy', as: :destroy_admin_session
  end

  #-- 会員 --#
  scope module: :client do
    # ルート
    root to: 'static_pages#top'
    # 会員情報
    resource :clients, only: %i[edit update show] do
      collection do
        patch 'withdraw', to: 'clients#withdraw'
      end
    end
    # お気に入り機能
    resources :favorites, only: %i[create destroy], param: :expert_id
    # お悩み投稿機能
    resources :problems, only: %i[new create show update destroy]
  end
end
