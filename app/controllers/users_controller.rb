class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_new_session, :only => [:new, :create]  # 为登录提供一个@user_session对象
  
  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance| 
    "<span class='field_error'>#{html_tag}</span>"    
  end 
  
  layout "application"
  #layout "application", :only => [:new, :create]
 
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
    @title = "我的优客"
    @user = @current_user
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
  
  
private
 
  def require_new_session
    @user_session = UserSession.new
  end
end
