# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user, :current_user_session
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
 
  auto_complete_for  :event, :title #, :limit => 20, :order => 'id desc'  # 用于自动完成搜索
  
private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "请先登录"
      redirect_to new_user_session_url
      return false
    end
  end
  
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "请先退出"
      redirect_to account_url
      return false
    end
  end
  
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  # URL中查找跳转地址参数
  def ret_location
    params[:ret]
  end
  
  # 准备category数据
  def prepare_categories
    @categories = Category.all
  end
  
  # 保证事件是正确的用户在操作
  def correct_user
    @event = Event.find(params[:id])
    unless (!@event.nil? && @event.user == current_user) 
      flash[:notice] = "权限错误，请先登录"
      redirect_to forbidden_url
      return false
    end
  end
end
