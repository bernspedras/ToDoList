Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'welcome#index'
    
    mount ActionCable.server => '/cable'
	resources :users do
		resources :tasks do
			member do
				put :complete
				end
			end
    end
	
end
