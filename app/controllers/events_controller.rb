class EventsController < ApplicationController
  
  before_filter :require_user, :except => [:show]
  before_filter :correct_user, :only => [:edit, :update, :destroy]
  uses_tiny_mce

  layout "common"
  
  def index
    @events = Event.all()
  end

  def new
    @event = current_user.events.new()
    @category_opts = Category.list_options()
    @status_opts = Event.edit_status_options()
  end

  def create
    @event = current_user.events.build(params[:event])
    if @event.save
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
  end
  
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
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
    if !CanShowEvent?(@event)
      redirect_to forbidden_url
    end
    
    @title = @event.title
    #@event.IncrementViews
    if (current_user != @event.user)
      @event.increment!(:views)    # 直接调用increment函数更新
    end
  end

private
  def correct_user
    @event = Event.find(params[:id])
    unless (!@event.nil? && @event.user == current_user) 
      flash[:notice] = "权限错误，请先登录"
      redirect_to forbidden_url
      return false
    end
  end
  
  # 判断一个event是否可以对外显示
  def CanShowEvent?(event)
    if (event.status != 'published')
      return false     
    end
    return true
  end

  
end
