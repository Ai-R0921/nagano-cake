Rails.application.routes.draw do

  scope module: 'public' do
    resources :addresses, except: [:show, :new]
    resources :orders, except: [:edit, :update, :destroy]
    post 'orders/confirm'
    get 'orders/complete'
    resources :cart_items, except: [:new, :show, :edit]
    delete 'cart_items/destroy_all'
    resources :customers, only: [:show, :edit, :update]
    get 'customers/unsubscribe'
    patch 'customers/withdraw'
    resources :items, only: [:index, :show]
    root to: 'homes#top'
    get '/about' => 'homes#about',as:"about"
  end


  namespace :admin do
    patch 'order_details/update'
    resources :orders, only: [:show, :update]
    resources :customers, except: [:new, :create, :destroy]
    resources :genres, except: [:new, :show, :destroy]
    get '/' => 'homes#top', as: 'top'
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
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
