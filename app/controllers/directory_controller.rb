class DirectoryController < ApplicationController
  def index
    @categories = Category.all
    @events = Event.published().with_category(params[:category_id]).with_in(params[:start_time]).paginate(:page => params[:page])   
  end
end
