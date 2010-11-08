class PagesController < ApplicationController
  before_filter :prepare_categories
  def home    
    @user_session = UserSession.new
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
