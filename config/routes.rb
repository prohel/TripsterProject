TripsterProject::Application.routes.draw do
  resources :attachment_comments


  resources :album_comments


  resources :attachments


  resources :albums


  resources :trip_invites


  resources :user_locations


  resources :locations

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :users

  match 'like' => 'users#like', :via => [:post]
  match 'unlike' => 'users#unlike', :via => [:post]
  get 'newsfeed' => 'newsfeed#index'
  resources :locations
  resources :trips_invites do
    collection do
      post 'requestTrip'
      # post 'acceptRequest'
      # post 'declineRequest'
      # get 'hasJoiningTripBeenRequested'
    end
  end

  resources :trips do
    resources :albums do
      resources :album_comments
      resources :album_ratings
    end
    resources :attachments do
      resources :attachment_comments
      resources :attachment_ratings
    end
    collection do
      get 'search'
      get 'invite'
      get 'showTripNotifications'
    end
  end

  resources :users do
    collection do
      get 'search'
      get 'recommend'
    end
  end

  root to: 'trips#index'
  get 'friend/:id', to: 'users#addFriend', as: 'friend'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
