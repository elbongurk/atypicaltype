AtypicalType::Application.routes.draw do
  get 'oauth/callback', to: 'o_auth#callback'
  get 'sign_in', to: 'o_auth#connect'
  get 'sign_out', to: 'o_auth#disconnect'

  resources :photos, only: [:index, :show]

  resource :cart, only: [:show] do
    resources :line_items, only: [:create, :update, :destroy]
  end

  resources :orders, only: [:new, :index, :show] do
    get 'confirm', on: :new
  end

  get 'privacy', to: 'pages#privacy'
  get 'terms', to: 'pages#terms'
  root to: 'pages#welcome'
end

