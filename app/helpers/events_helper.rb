module EventsHelper
  def ShowEventStatus(status)
    case status
    when 'published'    : '发布'
    when 'draft'        : '草稿'
    end
  end
  
  # 判断某用户是否收藏了一个事件
  def has_add_env_fav?(userid, eventid)    
    UserFavEvent.first.has_add_env_fav?(userid, eventid)     
  end
  
  
end
