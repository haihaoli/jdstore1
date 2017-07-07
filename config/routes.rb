Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "products#index"

  resource :welcome

  namespace :admin do
    resources :products
  end

  namespace :account do
    resources :orders
  end

  resources :products do
    member do
      post :add_to_cart
    end
  end

  resources :carts do
    member do
      delete :cart_clean
      post :order_confirm
    end
  end

  resources :cart_items

  resources :orders do
    member do
      post :alipay
      post :wechan
    end
  end

  resources :productlists

end
