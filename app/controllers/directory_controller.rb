class DirectoryController < ApplicationController
  def index
    @categories = Category.all
    @events = Event.published().category(params[:category_id]).in(params[:start_time])    
  end
end
