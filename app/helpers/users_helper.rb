module UsersHelper
  
  def GetOrderImg(sort, type)
    img_up = '<img width="9" height="9" src="/images/blue_up.gif">'
    img_down = '<img width="9" height="9" src="/images/blue_down.gif">'
    img_none = ''
    if sort.nil?
      return img_none
    end
    
    if (sort.index(type).nil?)      # 如果url携带的排序参数不是当前排序字段，则不需要显示方向。
      return img_none
    end
    
    if (sort.index('_desc').nil?)   #如果url携带的是desc，那么下一步链接就是asc
      return img_up
    else
      return img_down
    end
   
  end  # end of GetOrderImg
  
  def GetTitleLink(param_sort, sort, filter, title)
    if filter.nil?
      filter = 'living'
    end
    
    sortby = ''
    if (!param_sort.present?)    
      sortby = sort             # eg: title
    elsif ( (!param_sort.index(sort).nil?) && (param_sort.index('_desc').nil?) )
      sortby = sort + '_desc'   # eg: title_desc
    else
      sortby = sort             # eg: title
    end
    
    link_to title, url_for(:filter => filter, :sortby => sortby)   # 这里默认使用了当前页面的url。
  end
  
  
  # 用户一是否关注过用户二，未实现
  def has_add_user_fav?(userid_1, user_id_2)
    false
  end
end
