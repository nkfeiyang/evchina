class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :my_events, :my_orders, :my_order_detail, :my_fav_events, :participate]
  before_filter :require_new_session, :only => [:new, :create]  # 为登录提供一个@user_session对象
  
  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance| 
    "<span class='field_error'>#{html_tag}</span>"    
  end 
  
  layout "application", :only => [:new, :create]
  
  
  layout "user", :only => [:show, :edit, :update, :my_events, :my_orders, :my_order_detail, :my_fav_events]
    
  
  def new    
    @title = "新用户注册"
    @user = User.new
    render 'new'
  end
  
  def create    
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "注册成功!"
      redirect_back_or_default account_url
    else
      flash[:notice] = "注册失败!"   
      @title = "新用户注册"
      render 'new'
    end
  end
  
  def show
    #@title = "我的优客"
    #@user = @current_user
    redirect_to my_events_url
  end

  def edit
    @title = "我的优客"
    @user = @current_user
  end
  
  def update
    @title = "我的优客"
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "更新成功!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  # 我发起的活动
  def my_events
    @nav_title = @title = '我发起的活动'
    @my_events_living_count   = current_user.events.living.count
    @my_events_finished_count = current_user.events.finished.count
    if (params[:filter].nil? || params[:filter].casecmp('living') == 0)  # 当前页面是living
      @my_events_show = current_user.events.living.order_by(params[:sortby])      
    else                                                                 # 当前页面是finished
      @my_events_show = current_user.events.finished.order_by(params[:sortby])      
    end
  end  
 
  
  # 我参与的活动
  def my_orders
    @nav_title = @title = '我参与的活动'
    @my_participate_orders = current_user.ticket_orders
  end
  
  def my_order_detail
    @nav_title = @title = '订单详情'
    @my_order = current_user.ticket_orders.find_by_id(params[:order_id])
    if @my_order.nil?
      redirect_to forbidden_url
      return
    end
    @my_order_details = @my_order.ticket_order_details
    @required_infos = EventRegRequire.find_all_by_event_id(@my_order.event.id)  
  end
  
  # 参加活动
  def participate
    @event = Event.find(params[:event_id])    
    @order_quantity = params[:order_quantity].to_i
    if (@event.nil? || !@event.EnableParticipate? || @order_quantity <= 0 )
        redirect_to forbidden_url
        return
    end
    @required_infos = EventRegRequire.find_all_by_event_id(@event.id)  
      
    if params[:next] == 'participate_confirm'  # 从participate页面提交注册活动确认
      save_participate
    else  # 从show event页面提交
      
      render :action => 'participate', :layout => 'common'
    end    
  end
  
  # 我收藏的活动
  def my_fav_events
    @nav_title = '我收藏的活动'
    @my_events_living = current_user.fav_events.living.order_by(params[:sortby]) 
    @my_events_finished = current_user.fav_events.finished.order_by(params[:sortby]) 
    if (params[:filter].nil? || params[:filter].casecmp('living') == 0)
      @my_events_show = @my_events_living
    else
      @my_events_show = @my_events_finished
    end
  end
  
private
 
  def require_new_session
    @user_session = UserSession.new
  end
  
  # 存储用户的订购信息
  # 1.检查用户输入的注册信息是否完善（必填的是否都填了）
  # 2.创建一个订单，写入表ticket_orders
  # 3.将订单详情写入ticket_order_details表
  def save_participate
    user_attend_infos = []    
    
    if @event.each_need_reginfo && @order_quantity > 1     
      for info in @required_infos        
        collect_sys_reg_info_ids = params['sys_reg_info_id_' + info.sys_reg_info.id.to_s] # 这里保存的是某个选项的数组，比如3组姓名。
        
        if collect_sys_reg_info_ids.length != @order_quantity  # 不相等，则提交的表单可能是伪造的。
          redirect_to forbidden_url
          return
        end
                
        for i in 0 .. collect_sys_reg_info_ids.length-1
          v = collect_sys_reg_info_ids[i]
          if info.required && (v.nil? || v.strip.length == 0)  # 如果这个info是必填，那么就检查每个报名者的该项是否填写了。
              @error = '请注意:您有必填项没有输入!'
              render :action => 'participate', :layout => 'common'
              return              
          end          
          user_attend_infos << [i+1,[info.sys_reg_info.id, v]]   # 保存下来，后面使用          
        end  # end of for t in collect_sys_reg_info_ids
      end # end of info in @required_infos
    else  # 只需填一项用户注册信息时
      for info in @required_infos   
        v = params['sys_reg_info_id_' + info.sys_reg_info.id.to_s] 
        if info.required && (v.nil? || v.strip.length == 0)
            @error = '请注意:您有必填项没有输入!'
            render :action => 'participate', :layout => 'common'
            return              
        end          
        user_attend_infos << [1,[info.sys_reg_info.id, v]] 
      end
    end # end of @event.each_need_reginfo && @order_quantity > 1      
   
    # add order
    TicketOrder.create!(:user_id=>current_user.id, :event_id=>@event.id, :price=>@event.price, :ticket_counts =>@order_quantity)
    order_id = TicketOrder.first(:order=>"id desc").id
    
    # add order details
    for info in user_attend_infos
      sys_reg_info_id = EventRegRequire.find_by_event_id_and_sys_reg_info_id(@event.id, info[1][0]).sys_reg_info_id
      TicketOrderDetail.create!(:ticket_order_id=>order_id,:ticket_order_small_id=>info[0], :sys_reg_info_id=>sys_reg_info_id,:reg_info_value=>info[1][1])
    end
    
    redirect_to my_orders_url
  end
end
