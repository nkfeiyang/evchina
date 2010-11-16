# 统计管理
class StatsController < ApplicationController
  before_filter :correct_user, :init
  layout "user"
  
  def index
    
  end
  
private
  def init
    @nav_title = @title = '活动统计分析'
  end
end