Rails.application.routes.draw do
  devise_for :businesses
  devise_for :admins
  patch 'admins/update_name' => 'admins#admin_update_name'
  patch 'admins/update_password' => 'admins#admin_update_password'
  get 'admins/list' => 'admins#list'
  post 'admins/update' => 'admins#admin_update'
  get 'admins/workload' => 'admins#admin_statistics_workload'
  get 'admins/jsonworkload' => 'admins#admin_workload_json'
  get 'admins/jsonlist' => 'admins#jsonlist'
  get 'admins/tickets/status_list' => 'tickets#status_list'
  get 'admins/tickets/json_status_list' => 'tickets#json_status_list'
  post 'admins/tickets/pass' => 'tickets#pass'
  post 'admins/tickets/update' => 'tickets#admin_update'
  get 'admins/businesses/status_list' => 'businesses#status_list'
  get 'admins/businesses/json_status_list' => 'businesses#json_status_list'
  post 'admins/businesses/pass' => 'businesses#pass'
  post 'admins/businesses/update' => 'businesses#admin_update'
  get 'admins/businesses/list' => 'businesses#list'
  get 'admins/businesses/json_list' => 'businesses#json_list'
  get 'admins/businesses/statistics' => 'businesses#statistics'
  get 'admins/businesses/json_statistics' => 'businesses#json_statistics'
  get 'admins/scenics/type' =>'scenics#scenics_option'
  get 'admins/tickets/type' =>'tickets#tickets_option'
  get '/admins/tickets/list' => 'tickets#tickets_list'
  get '/admins/tickets/json_list' => 'tickets#tickets_json_list'
  get '/admins/orders/statistics' => 'orders#statistics'
  patch 'businesses/update_name' => 'businesses#admin_update_name'
  patch 'businesses/update_password' => 'businesses#admin_update_password'
  resources :admins
  resources :businesses
  namespace :api do 
    resources :users
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
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
