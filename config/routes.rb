Rails.application.routes.draw do
  devise_for :users

  root 'places#index'

  mount Api::Base => ''

  resources :places do
    resources :wallets, only: [:new, :create] do
      get :send_pass
    end
  end
end