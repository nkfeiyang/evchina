module DirectoryHelper
  def filter_Uri(var, val)
    ret = "";
    val = val.to_s
    category_id = ""
    if (var.downcase == "category_id")
      category_id = val
    else
      category_id = params[:category_id].blank? ? "" : params[:category_id]
    end
    
    if (category_id != "")
      ret = ret + '&category_id=' + category_id
    end    
    
    start_time = ""
    
    if (var.downcase == "start_time")
      start_time = val
    else
      start_time = params[:start_time].blank? ? "" : params[:start_time]
    end
    
    if (start_time != "")
      ret = ret + '&start_time=' + start_time
    end
    
    # 添加query部分
    ret = ret + (params[:q].blank? ? "" : '&q=' + params[:q])
    
    if (!ret.blank?)
      ret[0] = '/directory?'
    else
      ret = '/directory'
    end
    
    return ret
    
  end
  
  # 获得某个category下的事件数
  def get_category_count(category_id)
    return Event.published().with_user_id(params[:user_id]).with_in(params[:start_time]).with_query(params[:q]).with_category(category_id).count    
  end
  
  
  # 获得某个timespan下的事件数
  def get_time_range_count(timespan)
    return Event.published().with_user_id(params[:user_id]).with_in(timespan).with_query(params[:q]).with_category(params[:category_id]).count    
  end
  
  def GetCategoryCssClass(cate_id)
    if (params[:category_id] == cate_id.to_s || (params[:category_id].nil? && cate_id.blank?))
      return 'active'
    else
      return ''
    end
  end
  
  def GetTimeRangeCssClass(timename)
    if (params[:start_time] == timename || (params[:start_time].nil? && timename.blank?))
      return 'active'
    else
      return ''
    end
  end
  
  
  def format_event_interval(event)  # event是一个Event对象
    s = event.start_time
    e = event.end_time
    
    if (s.year != e.year)
      return s.strftime("%Y年%m月%d日%H:%M") + '至' + e.strftime('%Y年%m月%d日%H:%M')
    elsif (s.month != e.month)
      return s.strftime("%Y年%m月%d日%H:%M") + '至' + e.strftime('%m月%d日%H:%M')
    elsif (s.day != e.day)
      return s.strftime("%Y年%m月%d日%H:%M") + '至' + e.strftime('%d日%H:%M')
    else
      return s.strftime("%Y年%m月%d日%H:%M") + '至' + e.strftime('%H:%M')
    end    
  end
  
end
