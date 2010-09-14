module DirectoryHelper
  def filter_Uri(var, val)
   
    category_id = ""
    if (var.downcase == "category_id")
      category_id = val
    else
      category_id = params[:category_id].nil? ? "" : params[:category_id]
    end
    
    start_time = ""
    
    if (var.downcase == "start_time")
      start_time = val
    else
      start_time = params[:start_time].nil? ? "" : params[:start_time]
    end
    
    return '?category_id=' + category_id + '&start_time=' + start_time
    
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
    if (params[:category_id] == cate_id.to_s)
      return 'red'
    else
      return ''
    end
  end
  
  def GetTimeRangeCssClass(timename)
    if (params[:start_time] == timename)
      return 'red'
    else
      return ''
    end
  end
  
  
end
