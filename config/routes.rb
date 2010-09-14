ActionController::Routing::Routes.draw do |map|
  
  map.home    '/home',    :controller => 'pages', :action => 'home'
  map.contact '/contact', :controller => 'pages', :action => 'contact'
  map.about   '/about',   :controller => 'pages', :action => 'about'
  map.help    '/help',    :controller => 'pages', :action => 'help'
  
  map.resources :categories

  map.resource :account, :controller => "users"
  map.resources :users
  map.resource :user_session
  #map.root :controller => "user_sessions", :action => "new"
  map.resources :events
  
  map.signup  '/signup',  :controller => 'users', :action => 'new'
  map.signin    '/signin',  :controller => 'sessions', :action => 'new'
  map.signout   '/signout', :controller => 'sessions', :action => 'destroy'
  
  map.root :controller => "pages", :action => 'home'
   
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
