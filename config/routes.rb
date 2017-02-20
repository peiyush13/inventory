Rails.application.routes.draw do

  get 'purchase_account/new'

  get 'purchase_account/bill'

  get 'purchase_account/displayallpurchase'

  get 'purchase_account/search'

  get 'purchase_account/search_company'

  get 'purchase_account/getpurchaseinfo'

  get 'purchase_account/getpaymentinfo'

  get 'purchase_account/sort'

  
  devise_for :admins
  
  get 'sales/new'

  get 'sales/bill'

  get 'sales/displaybill'

  get 'sales/displayallsale'

  get 'sales/getsalesinfo'

  get 'sales/search'

  get 'sales/search_customer'

  get 'sales/sort'

  get 'stock_list/add'

  get 'stock_list/delete'

  get 'stock_list/display'

  get 'stock_list/update'

  get 'stock_list/sort'

  get 'expense_account/add'

  get 'expense_account/display'

  get 'expense_account/update'

  get 'expense_account/delete'

  get 'expense_account/sort'

  get 'summary/info'

  get 'admins/login'

  get 'admins/signup'

  get 'expense/delete'
  
  post 'admins/login'

  post 'admins/signup'

  post 'admins/login_check'

  post 'admins/signup_check'

  post 'expense_account/create'
  
  post 'expense_account/delete'

  post 'expense_account/update'
  
  post 'expense_account/update_expense'

  post 'expense_account/sort'

  post 'stock_list/create'

  post 'stock_list/update'

  post 'stock_list/sort'

  post 'sales/search'

  post 'sales/new'

  post 'sales/bill'

  post 'sales/getsalesinfo'

  post 'sales/search_customer'

  post 'sales/sort'

  post 'purchase_account/search'

  post 'purchase_account/new'

  post 'purchase_account/bill'

  post 'purchase_account/getpurchaseinfo'

  post 'purchase_account/getpaymentinfo'

  post 'purchase_account/search_company'

  post 'purchase_account/addpayment'
  
  post 'purchase_account/sort'



  # match ':controller(/:action)',:via=>get

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
     # resources :stock_list do
     #   member do
     #     get 'update'
     #     post 'update'
     # end
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
