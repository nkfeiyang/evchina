class PagesController < ApplicationController
  
  def home    
    @user_session = UserSession.new
  end

  def contact
  end

  def help
    
  end
  
  def about
    
  end
end
