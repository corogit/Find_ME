Rails.application.routes.draw do
  get '/' => 'homes#top'
  get 'about' => 'homes#about'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'

  resources :users, only: [:show, :edit, :update]
  get "user/:id/unsubscribe" => "users#unsubscribe", as: 'user_unsubscribe'
  patch 'user/:id/withdraw' => 'users#withdraw', as: 'user_withdraw'

  resources :rooms, only: [:index, :create, :show]

  resources :genres

  resources :pets do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  get "search" => "pets#search"

  resources :users do
    member do
      get :followings, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
