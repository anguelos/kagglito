Kagglito::Application.routes.draw do
  
   resources :chalenges do
	member do 
		get :showgt
		get :showinput
	end
  end
 
 
  resources :submissions do
    member do
      get :showresponse
      get :showchalengeinput
      get :chalengepngclient
      post:submitresponseclient
    end
  end

  devise_for :users
  #devise_for :users, :path_prefix => 'd'

  #resources :users

  resources :participations do
    member do
      get :chainsolutionget
      post:chainsolutionsubmit
      get :listsubmissionsclient
    end
  end

  resources :competitions do
	member do
		post :participate
    post :evaluateSubmissions
	end
  end

  resources :evaluators

  resources :datasets do
	member do
		post :copy
	#	get :myindex
	end
  end

  # route to the pages - creates 2 helpers to use in the controllers and views: f.ex. 1. contact_path 2. contact_url (to have complete url)
  match '/manageadmin',:to =>'pages#manageadmin'
  match '/userstats',:to =>'pages#userstats'

  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'
  
  match '/signup', :to => 'users#new'

  match '/mydatasets',:to => 'datasets#myindex'
  match '/myevaluators',:to => 'evaluators#myindex'
  match '/mycompetitons',:to => 'competitions#myindex'
  match '/myparticipations',:to => 'participations#myindex'
  
  match '/listparticipations',:to =>'participations#listclient'

  # just remember to delete public/index.html.
  root :to => 'pages#home' 
  
  #get "pages/home"
  #get "pages/contact"
  #get "pages/about"
  #get "users/new"

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
  # match ':controller(/:action(/:id(.:format)))'
end
