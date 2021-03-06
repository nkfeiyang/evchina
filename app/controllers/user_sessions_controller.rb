class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  layout "common"
  
  def new
    @title = "登录"
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "登录成功!"
      redirect_back_or_default account_url
    else
      flash.now[:error] = "错误的用户名/密码!"
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "成功退出!"
    redirect_back_or_default  signin_url
  end
end
