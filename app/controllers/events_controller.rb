class EventsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :new, :index]
  before_action :admin_user, only: [:create, :destroy, :new]

  def index
    @events = Event.paginate(page: params[:page], :per_page => 3)
  end
  
  def show
    @event = Event.find(params[:id])
    @photos = @event.photos.all
  end
  
  def new
    @event = Event.new
    @photos = @event.photos.build
  end
  
  def create
    @event = Event.new(event_params)
    if @event.save
      if !params[:photos].nil?
        params[:photos]['image'].each do |a|
          @photos = @event.photos.create!(:image => a, :imageable_id => @event.id)
        end
      end
      flash[:success] = "Event created!"
      redirect_to events_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    flash[:success] = "Event deleted."
    redirect_to events_url
  end

  private

    def event_params
      params.require(:event).permit(:title, :event_type, :date_time, :about, :location, photos_attributes: [:id, :imageable_id, :image])
    end
end
  