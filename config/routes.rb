Rails.application.routes.draw do

  # メール確認（開発環境用）
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

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
    get 'about', to: 'static_pages#about'
    # 会員情報
    resource :clients, only: %i[edit update show] do
      # 相談予約機能
      resources :consultations, only: %i[new create show], shallow: true
      get 'new.json'   => 'consultations#new', defaults: { format: :json }
      collection do
        patch 'withdraw', to: 'clients#withdraw'
      end
    end
    # お気に入り機能
    resources :favorites, only: %i[create destroy], param: :expert_id
    # お悩み投稿機能
    resources :problems, only: %i[new create show update destroy] do
      # 投稿内容のコメント機能
      resources :comments, only: %i[create update destroy]
    end
    # 専門家検索機能
    resources :experts, only: %i[index show]
  end

  #-- 専門家 --#
  namespace :expert do
    # ルート
    root to: 'static_pages#top'
    # 専門家情報
    resource :experts, only: %i[show edit update], shallow: true do
      resource :bookmarks, only: %i[create destroy]
      resource :careers, only: %i[create destroy], param: :career_id
      resource :expertise_tags, only: %i[create destroy], param: :tag_id
      resource :offices, only: %i[create update], param: :office_id
      # 相談情報
      resources :consultations, only: %i[index show update]
    end

    # 投稿内容
    resources :problems, only: %i[index show] do
      # 投稿内容のコメント機能
      resources :comments, only: %i[create update destroy]
    end
  end

  # 管理者
  namespace :admin do
    root to: 'static_pages#top'
    # 専門家情報
    resources :experts do
      resources :offices, only: %i[edit update]
      collection do
        patch 'withdraw/:id', to: 'experts#withdraw', as: 'withdraw'
        get 'offices/new', to: 'offices#new'
        post 'offices', to: 'offices#create'
      end
    end
    # 会員情報
    resources :clients, only: %i[index show] do
      collection do
        patch 'withdraw/:id', to: 'clients#withdraw', as: 'withdraw'
      end
    end
    # マスタデータ
    resources :jobs, only:  %i[index create update destroy]
    resources :trouble_tags, only:  %i[index create update destroy]
  end
end
