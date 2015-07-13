Rails.application.routes.draw do

  root 'pages#home'

  resources :products do
    resources :reviews, only: [:show, :create, :destroy]

    # /products/:id/add_to_cart
    member do
      get 'add_to_cart', to: "products#add_to_cart"
      post 'add_to_button', to: "products#add_to_button"
    end

    collection do
      post 'button_order', to: "products#button_order"
    end
  end

  get '/users/products', to: 'users#user_products'

  resources :users do
    resources :buttons do
      member do
        get 'products', to: 'buttons#products'
      end

      collection do
        get 'login', to: 'buttons#login'
        post 'authenticate', to: 'buttons#authenticate'
        get 'logout', to: 'buttons#logout'
      end
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :cart_items, only: :destroy

  resources :cart, only: :index do
    # /cart/checkout
    collection do
      get 'checkout', to: 'cart#checkout'
      get 'order', to: 'cart#order'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
