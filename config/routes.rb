Rails.application.routes.draw do

  namespace :api do
      resources :categories, :products, :defaults => {:format => 'json'}

      # get 'categories' => 'category#index', :defaults => {:format => 'json'}
      # get 'categories/:id' => 'category#show', :defaults => {:format => 'json'}
      # post 'categories' => 'category#create', :defaults => {:format => 'json'}

      # get 'products' => 'product#index', :defaults => {:format => 'json'}
      # get 'products/:id' => 'product#show', :defaults => {:format => 'json'}
  end

  namespace :admin do
    resources :category, :products, :users
    root 'category#index'
  end

  # You can have the root of your site routed with "root"
  root 'pages#welcome'

  # Route to document page
  get 'pages/doc' => 'pages#doc'

  %w( 404 422 500 ).each do |code|
    get code, :to => "errors#show", :code => code
  end

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
