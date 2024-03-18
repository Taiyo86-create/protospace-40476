Rails.application.routes.draw do
  Rails.application.routes.draw do
    devise_for :users
    root to: 'prototypes#index'

    # ユーザーリソースのルーティング
    resources :users, only: [:show, :edit, :update]

    # プロトタイプリソースのルーティング
    resources :prototypes, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
  end

end
