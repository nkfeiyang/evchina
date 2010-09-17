module DirectoryHelper
  def filter_Uri(var, val)
    ret = "";
    val = val.to_s
    category_id = ""
    if (var.downcase == "category_id")
      category_id = val
    else
      category_id = params[:category_id].nil? ? "" : params[:category_id]
    end
    
    if (category_id != "")
      ret = ret + '&category_id=' + category_id
    end    
    
    start_time = ""
    
    if (var.downcase == "start_time")
      start_time = val
    else
      start_time = params[:start_time].nil? ? "" : params[:start_time]
    end
    
    if (start_time != "")
      ret = ret + '&start_time=' + start_time
    end
    
    if (!ret.blank?)
      ret[0] = '?'
    else
      ret = '?'
    end
    
    return ret
    
  end
  
  # 获得某个category下的事件数
  def get_category_count(category_id)
    return Event.published().with_in(params[:start_time]).with_category(category_id).count    
  end
  
  # 获得总的事件数(限制条件为category之外的所有条件)
  def get_total_category_count
    Event.published().with_in(params[:start_time]).count
  end
  
  def get_time_range_count(timespan)
    return Event.published().with_in(timespan).with_category(params[:category_id]).count    
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
  
  def format_event_interval(event)
    s = event.start_time
    e = event.end_time
    hh = DateTime.parse(e.strftime("%Y-%m-%d")) - DateTime.parse(s.strftime("%Y-%m-%d"))
    
    if (hh == 0)
      return s.strftime("%Y-%m-%d %H:%M") + '至' + e.strftime('%H:%M')
    elseif (s.year == e.year)
      return s.strftime("%Y-%m-%d %H:%M") + '至' + e.strftime('%d %H:%M')
    else
      return s.strftime("%Y-%m-%d %H:%M") + '至' + e.strftime('%Y-%m-%d %H:%M')
    end    
  end
  
end
