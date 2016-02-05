Rails.application.routes.draw do

	# sitemap
	get 'sitemap.xml'  => 'crawlers#google', defaults: { format: 'xml' }
	get 'sitemap.atom' => 'crawlers#naver',  defaults: { format: 'atom' }

	# home
  root 'home#index'

	resources :stores, shallow: true do
		resources :store_errs, only: [:new, :create, :destroy]
	end
	resources :store_errs, only: [:index]
	resources :winners, only: [:index]

	get 'home/change_rounds'
  get 'portals/:id/news' => 'portals#news', as: :news

  devise_for :users, controllers: {
		passwords: "users/passwords",
		registrations: "users/registrations",
		sessions: "users/sessions",
		confirmations: "users/confirmations",
		# unlocks: "users/unlocks",
		# omniauth_callbacks: "users/omniauth_callbacks"
	}

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
