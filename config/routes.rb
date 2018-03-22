Rails.application.routes.draw do
  get 'debts/new'

# You can have the root of your site routed with "root"
  
  root 'enteros#new'
  resources :sessions, only:[:new, :create, :destroy]
  get "/login" => "sessions#new", as: "login"
  delete "/logout" => "sessions#destroy", as: "logout"
  
  resources :enteros do
      collection do
        get 'showRecipts', to: 'enteros#showRecipts'
        get 'buildpdf', to:'enteros#buildPdf'
        get 'showEntero', to:'enteros#showEntero'
        get 'insertServices', to:'enteros#insertServices'
        get 'deleteServices', to:'enteros#deleteServices'
        post 'putService', to:'enteros#putService'
        delete 'popService', to:'enteros#popService'
      end
  end
  
  resources :concessionaries do
    collection do
      get 'get_byName', to:'concessionaries#get_byName'
    end
  end
  
  resources :vehicles do
      resources :debts, only: [:create, :destroy]
  end
  
# automatically by rails
  #get 'sessions/new'
  #get 'sessions/create'
  #get 'sessions/destroy'
  #get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
end
