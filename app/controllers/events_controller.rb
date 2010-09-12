class EventsController < ApplicationController
  def index
    @events = Event.all()
  end

  def new
    @event = Event.new()
    @category_opts = Category.list_options()
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:success] = "Welcome to the Sample APP!"
      redirect_to @event
    else
      render 'new'
    end
  end
  
  def edit
    @event = Event.find(params[:id])
    @category_opts = Category.list_options()
    
  end
  
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = "event was successfully updated."
        format.html { redirect_to(:action => :index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def show
    @event = Event.find(params[:id])    
  end

end
