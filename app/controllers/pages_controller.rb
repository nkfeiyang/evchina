class PagesController < ApplicationController
  before_filter :prepare_categories
  
  
  
  def home    
    @user_session = UserSession.new
    @rec_events_cfg = CfgIndexEvent.valid
  end

  def contact
  end

  def help
    
  end
  
  def about
    
  end
  
  def findpass
    
  end
  
 
end
