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
  
  # 显示剩余的门票数
  def show_left_tickets(event)
    if event.total_tickets == 0
      return '十分充足'
    else
      return event.total_tickets - event.sold_tickets
    end    
  end  

  
  def get_ticket_options(event, number)  # number 为默认的张数
    if !(event.has_tickets?)
      return "<option value='0'>0</option>"
    else
      options = ''
      left = event.left_ticket_counts
      if event.total_tickets == 0 || left >= 30       # 如果剩余票数大于30，则最多显示30个，否则显示实际数量
        left = 30
      end   
      for i in 1..left do
        if number == i
          options << "<option vlaue='"+i.to_s+"' selected='selected'>"+i.to_s+"</option>"
        else
          options << "<option vlaue='"+i.to_s+"'>"+i.to_s+"</option>"
        end
      end
      options
    end  
  end
end
