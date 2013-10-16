AtypicalType::Application.routes.draw do
  get 'oauth/callback', to: 'o_auth#callback'
  get 'sign_in', to: 'o_auth#connect'
  get 'sign_out', to: 'o_auth#disconnect'
  
  resources :photos, only: [:index] do
    resources :variants, only: [:show]
    resources :products, only: [:show, :index]
  end

  resource :cart, only: [:show]
  resource :user, only: [:edit, :update]

  resources :line_items, only: [:create, :update, :destroy, :show]

  resources :orders, only: [:new, :create, :index, :show] do
    get 'purchase', on: :member
    get 'confirm', on: :member
  end
  
  resources :feedbacks, only: [:new, :create]

  get 'privacy', to: 'pages#privacy'
  get 'terms', to: 'pages#terms'
  get 'about', to: 'pages#about'

  root to: 'pages#welcome'

  if Rails.env.development?
    mount MessagePreview => 'message_preview'
  end
end

