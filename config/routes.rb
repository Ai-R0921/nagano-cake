Rails.application.routes.draw do

  namespace :public do
    resources :addresses, except: [:show, :new]
  end

  namespace :public do
    resources :orders, except: [:edit, :update, :destroy]
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    # get 'orders/confirm'
    # get 'orders/complete'
  end

  namespace :public do
    resources :cart_items, except: [:new, :show, :edit]
    delete :'cart_items/destroy_all', to: 'cart_items#destroy_all'
  end

  namespace :public do
    resources :customers, only: [:show, :edit, :update]
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
  end

  namespace :public do
    resources :items, only: [:index, :show]
  end

  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end

  namespace :admin do
    get 'order_details/update'
  end

  namespace :admin do
    resources :orders, only: [:show, :update]
    # get 'orders/show'
    # get 'orders/update'
  end

  namespace :admin do
    resources :customers, except: [:new, :create, :destroy]
  end

  namespace :admin do
    resources :genres, except: [:new, :show, :destroy]
  end

  namespace :admin do
    get 'homes/top'
  end

  namespace :admin do
    resources :items, except: [:destroy]
  end
  # devise_for :admins, skip: [:registrations, :passwords], controllers: {
  #   sessions: "admin/sessions"
  # }
  # devise_for :customers, skip: [:passwords], controllers: {
  #   registrations: "public/registrations"
  #   sessions: 'public/sessions'
  # }
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
