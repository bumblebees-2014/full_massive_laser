Rails.application.routes.draw do

  get 'home/show'

	get 'welcome/index'
	resources :users
	resources :tickets
	resources :professions


	resources :professionals

	 get 'auth/:provider/callback', to: 'users#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'users#destroy', as: 'signout'



root 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


# resources :users, :professions, :appointments, :professions
# root :to => 'welcome#index'

end
