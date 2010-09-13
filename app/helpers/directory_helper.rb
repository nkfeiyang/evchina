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
  

end
