Rails.application.routes.draw do
# automatically by rails
  #get 'sessions/new'
  #get 'sessions/create'
  #get 'sessions/destroy'
  #get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'
   resources :sessions, only:[:new, :create, :destroy]
   get "/login" => "sessions#new", as: "login"
   delete "/logout" => "sessions#destroy", as: "logout"
  
end
