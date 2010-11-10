ActionController::Routing::Routes.draw do |map|
  
  map.home      '/home',      :controller => 'pages', :action => 'home'
  map.contact   '/contact',   :controller => 'pages', :action => 'contact'
  map.about     '/about',     :controller => 'pages', :action => 'about'
  map.help      '/help',      :controller => 'pages', :action => 'help'
  map.findpass  '/findpass',  :controller => 'pages', :action => 'findpass'
  map.forbidden '/forbidden', :controller => 'pages', :action => 'forbidden'
  
  map.resources :categories

  map.resources :users
  map.resource :account, :controller => "users"

  map.resource :user_session
  #map.root :controller => "user_sessions", :action => "new"
  map.resources :events
  
  map.signup            '/signup',                :controller => 'users', :action => 'new'
  map.config            '/config',                :controller => 'users', :action => 'edit'
  map.signin            '/signin',                :controller => 'user_sessions', :action => 'new'
  map.signout           '/signout',               :controller => 'user_sessions', :action => 'destroy'
  
  map.my_events         '/myevents',              :controller => 'users', :action => 'my_events'    #我发起的活动
  map.create_event      '/create' ,               :controller => 'events', :action => 'new'
  map.my_orders         '/orders',                :controller => 'users', :action => 'my_orders' #我参与的活动
  map.my_order_detail   '/order_detail/:order_id',:controller => 'users', :action => 'my_order_detail', :requirements => {:order_id => /\d+/ } #活动详情
  map.my_fav_events     '/myfav',                 :controller => 'users', :action => 'my_fav_events'
  map.participate       '/participate/:event_id', :controller => 'users', :action => 'participate', :requirements => {:event_id => /\d+/ }   #活动报名
  
  map.root :controller => "pages", :action => 'home'
  
  # http://*/host/108,显示用户id为108的所有events。调用directory的user_events_list方法
  map.user_events "/host/:user_id", :controller => 'directory', :action => 'user_events_list', :requirements => {:user_id => /\d+/ } 
  
  map.add_user_fav '/add_fav/user/:user_id', :controller => 'fav', :action => 'add_user_fav' , :requirements => {:user_id => /\d+/ } 
  map.add_event_fav '/add_fav/event/:event_id', :controller => 'fav', :action => 'add_event_fav' , :requirements => {:event_id => /\d+/ } 
  map.rm_user_fav '/rm_fav/user/:user_id', :controller => 'fav', :action => 'rm_user_fav' , :requirements => {:user_id => /\d+/ } 
  map.rm_event_fav '/rm_fav/event/:event_id', :controller => 'fav', :action => 'rm_event_fav' , :requirements => {:event_id => /\d+/ } 
    
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
