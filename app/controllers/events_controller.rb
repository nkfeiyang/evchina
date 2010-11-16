class EventsController < ApplicationController
  
  before_filter :require_user, :except => [:show]
  before_filter :correct_user, :only => [:edit, :update, :destroy]
  uses_tiny_mce
  
  auto_complete_for  :event, :title #, :limit => 20, :order => 'id desc'

  layout "common"
  
  def index
    @events = Event.all()
  end

  def new
    @event = current_user.events.new()
    @category_opts = Category.list_options()
    @status_opts = Event.edit_status_options()
    @sys_reg_info_opts = SysRegInfo.list_options()
    @collect_infos =    EventRegRequire.find_all_by_event_id(@event.id).collect {|p| p.sys_reg_info_id}
    @collect_requires = EventRegRequire.find_all_by_event_id(@event.id).collect {|p| [p.sys_reg_info_id,p.required]}
  end

  def create
    @event = current_user.events.build(params[:event])    
    if @event.save
      UpdateEventRequireField(@event.id)
      flash[:success] = "创建活动成功!"
      redirect_to @event
    else
      render 'new'
    end
  end
  
  def edit
    @event = Event.find(params[:id])
    @category_opts = Category.list_options()
    @status_opts = Event.edit_status_options()
    @sys_reg_info_opts = SysRegInfo.list_options()
    @collect_infos = EventRegRequire.find_all_by_event_id(@event.id).collect {|p| p.sys_reg_info_id}
    @collect_requires = EventRegRequire.find_all_by_event_id(@event.id).collect {|p| [p.sys_reg_info_id,p.required]}
  end
  
  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update_attributes(params[:event])
        UpdateEventRequireField(@event.id)
        flash[:notice] = "event was successfully updated."
        format.html { redirect_to(:action => :show) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def show
    @event = Event.find(params[:id])   
    if !@event.CanShow?
      redirect_to forbidden_url
    end
    
    @title = @event.title
    #@event.IncrementViews
    if (current_user != @event.user)
      @event.increment!(:views)    # 直接调用increment函数更新
    end
  end

private
  
  
  

  # 更新用户报名的信息采集项
  def UpdateEventRequireField(event_id)
    collect_infos = params[:collect_infos]
    collect_requires = params[:collect_required]
    EventRegRequire.delete_all(:event_id=>event_id)
    if collect_infos.nil?
      return
    end
    
    if collect_requires.nil?
      collect_requires = []
    end 
    for info_id in collect_infos
      if  collect_requires.include?(info_id)
        EventRegRequire.create!(:event_id=>event_id,:sys_reg_info_id=>info_id,:required=>1)
      else
        EventRegRequire.create!(:event_id=>event_id,:sys_reg_info_id=>info_id,:required=>0)
      end
    end
  end
  
end
