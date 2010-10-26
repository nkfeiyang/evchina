class FavController < ApplicationController
  
  before_filter :require_user, :find_ret_location
  #before_filter :correct_user, :only => [:rm_user_fav, :rm_user_fav]
  
  # 添加用户一到用户二的追踪
  def add_user_fav
    
  end
  
  # 添加对某事件的收藏
  def add_event_fav
    event = Event.find(params[:event_id])
    unless (event.nil?)
      if (!UserFavEvent.first.has_add_env_fav?(current_user.id, event.id))
        UserFavEvent.create!(:user_id => current_user.id, :event_id => event.id)
      end
    end
    redirect_to @ret
  end
  
  # 删除用户一到用户二的追踪
  def rm_user_fav
    
  end
  
  # 删除对某事件的收藏
  def rm_event_fav
    #store_location
    ev_fav = UserFavEvent.find_by_user_id_and_event_id(current_user.id, params[:event_id])
    if !ev_fav.nil?
      UserFavEvent.destroy(ev_fav.id)      
    end
    redirect_to @ret
  end
    
  
private
  def correct_user
    @event = Event.find(params[:id])
    unless (!@event.nil? && @event.user == current_user) 
      flash[:notice] = "权限错误，请先登录"
      redirect_to forbidden_url
      return false
    end
  end
  
  def find_ret_location
    @ret = params[:ret]
  end
end