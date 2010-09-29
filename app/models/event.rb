class Event < ActiveRecord::Base
  
  #default_scope :order => 'start_time ASC, end_time ASC'
  belongs_to :user
  belongs_to :category
  belongs_to :host_info
  #validates_presence_of :content
  #validates_length_of :content, :maximum => 140
  
  named_scope :with_in, lambda { |period|
   period.present? ? { :conditions => {:start_time => TimeRange(period)}} : {} 
  #(period.present? && (!TimeRanges[period].nil?)) ? { :conditions => [:start_time => TimeRanges[period].call] } : {}
  }
  
  named_scope :finished,  :conditions => ['end_time <= ?', Time.now]     # 已结束的事件
  named_scope :starting,  :conditions => ['start_time <= ? and end_time > ?', Time.now, Time.now]    #正在进行的事件
  named_scope :unstart,   :conditions => ['start_time > ?', Time.now]    # 未开始的事件
  
  named_scope :published, :conditions => { :status => 'published' }    # 状态为公开的事件
  
  named_scope :with_category, lambda  { |category_id|
    category_id.present? ? {:conditions => ['category_id = ?', category_id]} : {}
  }
  
  named_scope :with_query, lambda { |q|
    q.present? ? {:conditions => ['(title like ?) or (content like ?)', '%'+q+'%', '%'+q+'%']} : {}
  }
  
  named_scope :with_user_id, lambda { |user_id|
    user_id.present? ? {:conditions => ['user_id = ?', user_id]} : {}
  }
  
  named_scope :order_by, lambda { |order|
    order.present? ? { :order => OrderType(order) } : {}
  }
  def IncrementViews
   # v = (views.nil? ? 0 : views)+1 
   # update_attribute(:views, v)
   # 直接调用increment方法，可以将指定字段的值加1，或者increment!(:views, 5)
   # increment!(:views)
  end
  
  
  private
    def self.TimeRange(period)   
      case period
        when 'today'              : Time.now.beginning_of_day..Time.now.end_of_day 
        when 'yesterday'          : Time.now.yesterday.beginning_of_day..Time.now.yesterday.end_of_day
        when 'tomorrow'           : Time.now.tomorrow.beginning_of_day..Time.now.tomorrow.end_of_day              #明天
        when 'this_week'          : Time.now.beginning_of_week..Time.now.end_of_week         #本周（周一到周末）
        when 'next_week'          : Time.now.next_week..Time.now.next_week.end_of_week         #下周（周一到周末）
        when 'last_week'          : 1.week.ago.beginning_of_week..1.week.ago.end_of_week      #上周（周一到周末）
        when 'this_month'         : Time.now.beginning_of_month..Time.now.end_of_month       #本月（1号到月底）
        when 'last_month'         : Time.now.prev_month.beginning_of_month..Time.now.prev_month.end_of_month #上月（1号到月底）
        when 'next_month'         : Time.now.next_month.beginning_of_month..Time.now.next_month.end_of_month #下月（1号到月底）
        when 'this_year'          : Time.now.beginning_of_year..Time.now.end_of_year            #今年
        when 'last_year'          : Time.now.prev_year.beginning_of_year..Time.now.prev_year.end_of_year        #去年
        when 'next_year'          : Time.now.next_year.beginning_of_year..Time.now.next_year.end_of_year #下一年
        when 'today_to_weekend'   : Time.now.beginning_of_day..Time.now.end_of_week    #今天开始到周末
        when 'today_to_monthend'  : Time.now.beginning_of_day..Time.now.end_of_month    #今天开始到月末
        when 'today_to_yearend'   : Time.now.beginning_of_day..Time.now.end_of_year     #今天到年末
        when 'this_weekend'       : Time.now.end_of_week.beginning_of_week-1.day..Time.now.end_of_week  #本周末
      end
    end

    def self.OrderType(order)
      case order
        when 'publish_date'                   : 'publish_date ASC'         #发表日期
        when 'publish_date_desc'              : 'publish_date DESC'
        when 'id'                             : 'id'
        else                                  ''
      end
    end
 
end
