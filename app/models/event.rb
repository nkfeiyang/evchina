class Event < ActiveRecord::Base
  
  #default_scope :order => 'start_time ASC, end_time ASC'
  belongs_to :user
  belongs_to :category
  belongs_to :city
  #belongs_to :host_info
  
  has_many :user_fav_events, :foreign_key => "event_id", :dependent => :destroy
  has_many :event_fav_by_users, :through => :user_fav_events, :source => :user
  has_many :event_reg_requires, :dependent => :destroy
  has_many :ticket_orders, :dependent => :destroy 
  has_many :cfg_index_events, :dependent => :destroy
  
  #validates_presence_of :content
  #validates_length_of :content, :maximum => 140
  
  named_scope :with_in, lambda { |period|
   period.present? ? { :conditions => {:start_time => TimeRange(period)}} : {} 
  #(period.present? && (!TimeRanges[period].nil?)) ? { :conditions => [:start_time => TimeRanges[period].call] } : {}
  }
  
  named_scope :finished,  :conditions => ['end_time <= ?', Time.now]     # 已结束的事件
  named_scope :starting,  :conditions => ['start_time <= ? and end_time > ?', Time.now, Time.now]    #正在进行的事件
  named_scope :unstart,   :conditions => ['start_time > ?', Time.now]    # 未开始的事件
  named_scope :living,    :conditions => ['end_time > ?', Time.now]      # 活动事件，凡是没有到结束时间的活动都认为是活动的。
  
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
  
  named_scope :with_city, lambda { |city_id|
    city_id.present? ? {:conditions => ['city_id = ?', city_id]} : {}
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
  
  # 定义状态字段对应的值和显示
  def self.status_options
    {'发布' => 'published', '草稿' => 'draft', '删除' => 'deleted'}
  end
  
  # 这用于新增和修改时
  def self.edit_status_options
    {'发布' => 'published', '草稿' => 'draft'}
  end
  
  # 判断一个event是否可以对外显示
  def CanShow?
    if (self.status != 'published')
      return false     
    end
    return true
  end
  
  # 判断一个事件是否允许报名。(本方法是实例方法)
  def EnableParticipate?
    (self.status == 'published') && (self.start_time >  Time.now) && (self.has_tickets?)  # 条件self.has_tickets?指有票可售
  end
  
  # 剩余票数，这里没有考虑不限票的情况
  def left_ticket_counts
    self.total_tickets - sold_tickets
  end
  
  # 是否有票可售
  def has_tickets?
     if self.total_tickets == 0 || self.left_ticket_counts > 0
      return true
    else
      return false
    end    
  end
  
  # 是否有足够需要的票可售
  def has_enough_tickets?(need)
    if (self.total_tickets == 0 || self.left_ticket_counts >= need)
      return true
    else
      return false
    end
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
        when 'title'                          : 'title ASC'
        when 'title_desc'                     : 'title DESC'
        when 'start_date'                     : 'start_time ASC'
        when 'start_date_desc'                : 'start_time DESC'
        when 'end_date'                       : 'end_time ASC'
        when 'end_date_desc'                  : 'end_time DESC'
        when 'status'                         : 'status ASC'
        when 'status_desc'                    : 'status DESC'
        else                                  ''
      end
    end
 
end
