# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title
    base_title = "优客网"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{h(@title)}"
    end
  end
  
  def logo
    image_tag("logo.gif", :alt => "Sample App", :class => "round")
  end
  
  def show_ev_date(d)
     return d.strftime("%Y年%m月%d日%H:%M")
 end
 
 # 判断两个时间之间相差的天数
 def DayDiff(t1, t2)   
     (t1-t2)/(24*60*60).to_int
 end
 
 # 截取字符串，替换原有的truncate方法，处理不要超过30字
 def truncate_u(text, length = 30, truncate_string = "...")  
     if r = Regexp.new("(?:(?:[^\xe0-\xef\x80-\xbf]{1,2})|(?:[\xe0-\xef][\x80-\xbf][\x80-\xbf])){#{length}}", true, 'n').match(text)  
         r[0].length < text.length ? r[0] + truncate_string : r[0]  
     else  
         text  
     end  
 end
 
end
