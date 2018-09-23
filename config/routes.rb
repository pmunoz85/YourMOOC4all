Rails.application.routes.draw do

  resources :evaluaciones do
    get 'listado', :on => :collection
  end

  resources :administrador do
    get 'index', :on => :collection
  end
#  get 'administrador/index'

  get 'inicio/index'

#  resources :inicio do
#    get 'index', :on => :collection
#  end

  resources :subtitulos do
    get 'listado', :on => :collection
  end

	resources :audios do
    get 'listado', :on => :collection
  end
	resources :transcripciones do
    get 'listado', :on => :collection
  end
	
	resources :cursos do
    get 'listado', :on => :collection
  end
  resources :universidades do
    get 'listado', :on => :collection
  end
	resources :proveedores do
    get 'listado', :on => :collection
  end
  resources :idiomas do
    get 'listado', :on => :collection
  end
	#devise_for :users
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
#  devise_for :users, :controller => {:registrations => "registrations"}
	#devise_for :users, :skip => [:registrations]
#  as :user do
#    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
#    put 'users' => 'devise/registrations#update', :as => 'user_registration'
#    get 'users/sign_out' => 'devise/sessions#destroy', :as => 'destroy_user_session_path'
#  end
#	devise_for :users do 
#    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
#    put 'users' => 'devise/registrations#update', :as => 'user_registration'
#    get 'users/sign_out' => 'devise/sessions#destroy', :as => 'destroy_user_session_path'
#	end
#  devise_for :users do 
#    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
#    put 'users/sign_up' => 'devise/registrations#update', :as => 'user_registration'
#    get 'users/sign_out' => 'devise/sessions#destroy', :as => 'destroy_user_session_path'
#  end
#devise_scope :user do
#	get 'login', to: "devise/sessions#new", as: "login"
#	get 'logout', to: "devise/sessions#destroy", as: "logout"
#	get 'logout', to: "users/sessions#destroy", as: "logout"
#	get 'signup', to: "users#new", as: "signup"
#	#match '/users/:id', :to => 'users#show', :as => :user
#end
	resources :users do
		get 'listado', :on => :collection
	end
  #get 'home/index'
  resources :home do
    get 'index', :on => :collection
#    get 'datos_uned', :on => :collection
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
	
#  root 'inicio#index'
  root 'home#index'
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
