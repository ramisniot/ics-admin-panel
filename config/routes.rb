Rails.application.routes.draw do
  resources :bar_codes
  resources :weight_calculators
  resources :employee_productivities 
  get 'productivity', to: 'employee_productivities#index'
  


  resources :charts do
    get :download_report
  end
  resources :trackers

  scope :ujs, defaults: { format: :ujs } do
    patch 'wt_totals' => 'weight_calculators#totals'
    patch 'thing_totals' => 'trackers#totals'
  end

  post 'search' => 'trackers#search'
  resources :import  do
    # post 'parts' => 'import#parts'
    collection do
      post :import
      post :parts
    end
  end
  resources :iot_data do
    # get  'process_start' => 'iot_data#process_start'
    # match '/process_start' => 'iot_data#process_start', via: :post
    # match '/request' => 'iot_data#process_start', via: :get
    # member do
      get :process_start
      get :download_report
      # get :print_pdf
    # end
    collection do
      post :import
      # get  :process_start #/:id' => 'iot_data#process_start'
    end
  end
  
  # resources :sensors
  devise_for :users, only: :session, path: 'session',
             path_names: { sign_in: 'login', sign_out: 'logout' }
  
  resources :users, only: [:show]
  
  # mount SensorsAdminPanel::V1 => '/'
  # mount GrapeSwaggerRails::Engine, at: "/documentation"

  root to: 'visitors#index'
  # root to: 'iot_data#index'
end
