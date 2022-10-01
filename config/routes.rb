Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  get "customers/my_page", to: 'public/customers#show', as:"customer"
  get "customers/infomation/edit", to: 'public/customers#edit', as:"edit_customer"

scope module: 'public' do
    root to: 'homes#top'
    get '/about' => 'homes#about',as:"about"
    post 'orders/confirm'
    get 'orders/complete'
    delete 'cart_items/destroy_all'
    get 'customers/unsubscribe'
    patch 'customers/withdraw'
    resources :addresses, except: [:show, :new]
    resources :orders, except: [:edit, :update, :destroy]
    resources :customers, only: [:edit, :update]
    resources :cart_items, except: [:new, :show, :edit]
    resources :items, only: [:index, :show]
  end



namespace :admin do
    get '/' => 'homes#top', as: 'top'
    patch 'order_details/update'
    resources :orders, only: [:show, :update]
    resources :customers, except: [:new, :create, :destroy]
    resources :genres, except: [:new, :show, :destroy]
    resources :items, except: [:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
