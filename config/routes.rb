Rails.application.routes.draw do
  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end
  devise_for :users, controllers: { sessions: "users/sessions" }, only: :sessions

  root 'home#index'
  get "/users" => "users#index", as: :users

  resources :users, only: [:edit, :update] do
    put "/password" => "users#update_password", as: :update_password
    get "/password" => "users#edit_password"
    get "/profile"  => "users#profile", as: :profile
  end

  get '/soon' => "home#coming_soon", as: :soon

  namespace :api do
    namespace :v1 do
      get '/me' => 'api#me'
    end
  end
  resources :users, :collection => { :list => :get }
  resources :clubs, :has_many => [:club_members], :collection => { :list => :get }

  get '/calendar' => 'calendar#index', as: :calendar

  #get '/clubs/new' => 'clubs#news', as: :clubs
  #get '/clubs' => 'clubs#list', as: :clubs_list
  get '/clubs/private' => 'clubs#list_private', as: :clubs_list_private
  get '/articles/private' => 'articles#list_private', as: :articles_list_private
  get '/events/private' => 'events#list_private', as: :events_list_private
  get '/clubs/subscribe' => 'clubs#subscribe', as: :clubs_subscribe
  get '/clubs/join' => 'clubs#join', as: :clubs_join
  #get '/clubs/:id' => 'clubs#profile', as: :clubs_profile
  get '/articles/article' => 'articles#article', as: :clubs_article
  get 'clubs/ajouter_membre/:id/:id' => 'clubs#ajouter_membre', as: "ajouter_membre"
  get '/events/calendar/public' => 'events#calendar_public'
  
  resources :clubs
  resources :articles
  resources :events
  resources :articles do
    resources :users, only: [:edit, :update, :destroy]
  end
  resources :events do
    resources :users, only: [:edit, :update, :destroy]
  end

  get '/files/*path' => 'files#index', as: :files
  get '/files' => 'files#index', as: :base_files

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
