class DirectoryController < ApplicationController
  
  before_filter :prepare_categories
  
  def index    
    @events = Event.published().with_category(params[:category_id])\
             .with_in(params[:start_time]).with_query(params[:q])\
             .with_city(params[:city_id])\
             .paginate(:page => params[:page], :per_page => 10)
    @cities = City.all()
  end
  
  def user_events_list    
    @events = Event.published()\
             .with_user_id(params[:user_id])\
             .with_category(params[:category_id])\
             .with_in(params[:start_time])\
             .with_query(params[:q])\
             .paginate(:page => params[:page], :per_page => 10)    
     @cities = City.all()
     render :action => 'index'
     
  end
  
private

end
