ActionController::Routing::Routes.draw do |map|
  
  map.home    '/home',    :controller => 'pages', :action => 'home'
  map.contact '/contact', :controller => 'pages', :action => 'contact'
  map.about   '/about',   :controller => 'pages', :action => 'about'
  map.help    '/help',    :controller => 'pages', :action => 'help'
  
  map.resources :categories

  map.resources :users
  map.resource :account, :controller => "users"

  map.resource :user_session
  #map.root :controller => "user_sessions", :action => "new"
  map.resources :events
  
  map.signup  '/signup',  :controller => 'users', :action => 'new'
  map.config  '/config',  :controller => 'users', :action => 'edit'
  map.signin    '/signin',  :controller => 'user_sessions', :action => 'new'
  map.signout   '/signout', :controller => 'user_sessions', :action => 'destroy'
  
  map.root :controller => "pages", :action => 'home'
  
  # http://*/user/events/108,显示用户id为108的所有events。调用directory的user_events_list方法
  map.user_events "/user/events/:user_id", :controller => 'directory', :action => 'user_events_list', :requirements => {:user_id => /\d+/ } 
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
