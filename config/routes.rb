Rails.application.routes.draw do
  resources :weight_calculators
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
    collection do
      post :import
      post :parts
    end
  end
  resources :iot_data do
      get :process_start
      get :download_report
    
    collection do
      post :import
    end
  end
  
  devise_for :users, only: :session, path: 'session',
             path_names: { sign_in: 'login', sign_out: 'logout' }
  
  resources :users, only: [:show]
  root to: 'visitors#index'
end
