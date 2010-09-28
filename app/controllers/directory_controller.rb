class DirectoryController < ApplicationController
  
  before_filter :prepare_data
  
  def index    
    @events = Event.published().with_category(params[:category_id])\
             .with_in(params[:start_time]).with_query(params[:q]).paginate(:page => params[:page], :per_page => 10)    
  end
  
  def user_events_list    
    @events = Event.published()\
             .with_user_id(params[:user_id])\
             .with_category(params[:category_id])\
             .with_in(params[:start_time])\
             .with_query(params[:q])\
             .paginate(:page => params[:page], :per_page => 10)    
     render :action => 'index'
  end
  
private
  def prepare_data
    @categories = Category.all
  end
end
