AtypicalType::Application.routes.draw do
  get 'oauth/callback', to: 'o_auth#callback'
  match 'sign_in' => 'o_auth#connect', :as => 'sign_in', :via => :get
  match 'sign_out' => 'o_auth#disconnect', :as => 'sign_out', :via => :get

  resources :photos, only: [:index, :show]

  resource :cart, only: [:show] do
    resources :line_items, only: [:create, :update, :destroy]
  end

  resources :orders, only: [:index, :show]

  root 'pages#welcome'
end
