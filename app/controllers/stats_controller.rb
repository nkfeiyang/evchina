# 统计管理
class StatsController < ApplicationController
  before_filter :correct_user, :init
  layout "user"
  
  def index
    @orders = TicketOrder.find_all_by_event_id(@event.id).paginate(:page => params[:page], :per_page => :per_page)
  end
  
  def show_detail
    @my_order = TicketOrder.find_by_id(params[:order_id])
    if @my_order.nil?
      redirect_to forbidden_url
      return
    end
    @my_order_details = @my_order.ticket_order_details
    @required_infos = EventRegRequire.find_all_by_event_id(@my_order.event.id)
    render :partial => 'stats/order_detail'
  end
private
  def init
    @nav_title = @title = '活动统计分析'
    @per_page = 10
  end
end