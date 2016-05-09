Rails.application.routes.draw do

  namespace :admin do
    resources :users do
      post :verify
    end
  end

  resource :phones do
    put :verify
  end
  resources :templates do
    get :add_more_sections, on: :collection
  end
  resources :profiles
  devise_for :users, :controllers => {:registrations => "registrations"}
  root "dashboard#index"

  resources :jobs do
    get 'openings', on: :collection
    get :change_status, on: :member
    resources :submissions do
      get :change_status, on: :member
      post :save_comment, on: :member
      get :add_attachments, on: :collection
      get :get_submission, on: :member
      resources :resumes
      resources :resume_sections
      resources :interviews
    end
  end
  
  get '/admin' => 'admin#index'

  get '/my_submissions' => 'submissions#my_submissions', as: 'my_submissions'

  get "/signup_success" => "home#signup_success"
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
