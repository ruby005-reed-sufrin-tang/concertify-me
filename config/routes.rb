Rails.application.routes.draw do


  resources :sessions
  resources :users, :only => [:show, :index] do
    resources :events
    resources :artists
  end
  resources :static_pages, :only => [:index, :about]
  root 'static_pages#index'
  get '/about' => 'static_pages#about'

  get '/events/top' => 'events#top', :as => :top_events

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => :signout

  post '/event_users' => 'event_users#create'
  get '/event_user' => 'event_users#create'
  delete '/event_user' => 'event_users#delete'
  post '/emails' => 'emails#create'
 
  patch '/users/:id' => 'users#update'
  resources :requests

  patch '/spotify_artists' => 'spotify_artists#update'
  get '/user/:id/artist_users/:id' => 'artist_users#show', :as => :artist_user
  delete '/user/:id/artist_users/:id' => 'artist_users#delete'

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
