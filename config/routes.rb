Rails.application.routes.draw do
  get '/' => 'homes#top'
  get 'about' => 'homes#about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  
  resources :users, only: [:show, :edit]
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  resources :genres, only: [:index, :create]
  
  resources :pets do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
