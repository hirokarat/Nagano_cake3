Rails.application.routes.draw do
 # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do

    resources:orders,only:[:index,:show,:update]
    resources:customers,only:[:index,:show,:edit,:update]
    resources:genres,only:[:index,:create,:edit,:update]
    resources:items,only:[:index,:new,:create,:show,:edit,:update]
    resources :order_details, only: [:update]
    root to:'homes#top'
  end

  # namespace :public do
  #   resources :orders, only: [:new, :create, :index, :show] do
  #     collection do
  #       post "confirm"
  #       get "complete"
  #     end
  #   end
  #   resources :items, only: [:index, :show]
  #   resources :cart_items, only: [:index, :update, :create, :destroy]
  #   delete "cart_items" => "cart_items#destroy_all", as: "cart_item_destroy_all"
  #   resources :addresses, only: [:index, :create, :destroy, :edit, :update]

  #   get 'customers/information/edit'=>'customers#edit',as: 'customer_edit'
  #   patch "update" => "customers#update", as: "customer_update"
  #   get 'customers/my_page'=>'customers#show',as: 'my_page'
  #   get "customers/unsubscribe" => "customers#unsubscribe", as: "customer_unsubscribe"
  #   patch "withdraw" => "customers#withdraw", as: "customer_withdraw"
  #   root to:'homes#top'
  #   get 'homes/about'=>'homes#about',as: 'about'
  # end
  
  
   scope module: :public do
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post "confirm"
        get "complete"
      end
    end
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :create, :destroy]
    delete "cart_items" => "cart_items#destroy_all", as: "cart_item_destroy_all"
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]

    get 'customers/information/edit'=>'customers#edit',as: 'customer_edit'
    patch "update" => "customers#update", as: "customer_update"
    get 'customers/my_page'=>'customers#show',as: 'my_page'
    get "customers/unsubscribe" => "customers#unsubscribe", as: "customer_unsubscribe"
    patch "withdraw" => "customers#withdraw", as: "customer_withdraw"
    root to:'homes#top'
    get 'homes/about'=>'homes#about',as: 'about'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
