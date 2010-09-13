
  TimeRanges = {
    :today => lambda{ Time.now.beginning_of_day..Time.now.end_of_day },
    :yesterday => lambda{ Time.now.yesterday.beginning_of_day..Time.now.yesterday.end_of_day },
    :tomorrow => lambda{ Time.now.tomorrow.beginning_of_day..Time.now.tomorrow.end_of_day },              #明天
    :this_week  => lambda { Time.now.beginning_of_week..Time.now.end_of_week },         #本周（周一到周末）
    :next_week  => lambda { Time.now.next_week..Time.now.next_week.end_of_week },         #下周（周一到周末）
    :last_week  => lambda { 1.week.ago.beginning_of_week..1.week.ago.end_of_week},      #上周（周一到周末）
    :this_month => lambda { Time.now.beginning_of_month..Time.now.end_of_month },       #本月（1号到月底）
    :last_month => lambda { Time.now.prev_month.beginning_of_month..Time.now.prev_month.end_of_month }, #上月（1号到月底）
    :next_month => lambda {Time.now.next_month.beginning_of_month..Time.now.next_month.end_of_month}, #下月（1号到月底）
    :this_year => lambda {Time.now.beginning_of_year..Time.now.end_of_year},            #今年
    :last_year => lambda {Time.now.prev_year.beginning_of_year..Time.now.prev_year.end_of_year},        #去年
    :next_year => lambda {Time.now.next_year.beginning_of_year..Time.now.next_year.end_of_year}, #下一年
    :today_to_weekend => lambda { Time.now.beginning_of_day..Time.now.end_of_week },    #今天开始到周末
    :today_to_monthend => lambda {Time.now.beginning_of_day..Time.now.end_of_month},    #今天开始到月末
    :today_to_yearend =>  lambda {Time.now.beginning_of_day..Time.now.end_of_year},     #今天到年末
    :this_weekend => lambda { Time.now.end_of_week.beginning_of_week-1.day..Time.now.end_of_week } #本周末
  }
