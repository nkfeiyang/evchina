ActionController::Routing::Routes.draw do |map|
  map.resources :categories

  map.resource :account, :controller => "users"
  map.resources :users
  map.resource :user_session
  map.root :controller => "user_sessions", :action => "new"
   map.resources :events
   
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
