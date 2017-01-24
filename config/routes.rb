Rails.application.routes.draw do
  resources :enteros do
      collection do
          get 'buildpdf', to:'enteros#buildPdf'
          get 'showEntero', to:'enteros#showEntero'
          get 'insertServices', to:'enteros#insertServices'
          get 'deleteServices', to:'enteros#deleteServices'
          post 'putService', to:'enteros#putService'
          delete 'popService', to:'enteros#popService'
          
      end
  end

# automatically by rails
  #get 'sessions/new'
  #get 'sessions/create'
  #get 'sessions/destroy'
  #get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'enteros#index'
   resources :sessions, only:[:new, :create, :destroy]
   get "/login" => "sessions#new", as: "login"
   delete "/logout" => "sessions#destroy", as: "logout"
  
end
