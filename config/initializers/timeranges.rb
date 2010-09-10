
  TimeRanges = {
    :today => lambda{ Time.now.beginning_of_day..Time.now.end_of_day },
    :yesterday => lambda{ 1.day.ago.beginning_of_day..1.day.ago.end_of_day },
    :this_week  => lambda { Time.now.beginning_of_week..Time.now.end_of_week },         #本周
    :last_week  => lambda { 1.week.ago.beginning_of_week..1.week.ago.end_of_week},      #上周
    :this_month => lambda { Time.now.beginning_of_month..Time.now.end_of_month },       #本月
    :last_month => lambda { 1.month.ago.beginning_of_month..1.month.ago.end_of_month }, #上月
    :today_to_weekend => lambda { Time.now.beginning_of_day..Time.now.end_of_week }, #今天开始到周末
    :this_weekend => lambda { Time.now.end_of_week.beginning_of_week-1.day..Time.now.end_of_week }
  }
