Rails.application.routes.draw do
  get 'pages/secret'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # Add a root route if you don't have one...
	# We can use users#new for now, or replace this with the controller and action you want to be the site root:
	root to: 'users#new'

  delete '/users', to: 'users#destroy', as: 'delete_user'
  	
  # sign up page with form:
  get 'users/new' => 'users#new'

  # create (post) action for when sign up form is submitted:
  post 'users' => 'users#create'

  # log in page with form:
	get '/login'     => 'sessions#new'
	
	# create (post) action for when log in form is submitted:
	post '/login'    => 'sessions#create'
	
	# delete action to log out:
	get '/logout' => 'sessions#destroy'  

  


  resources :users, only: [:index] do
    post :block, on: :collection
    post :unblock, on: :collection
  end

  

end


