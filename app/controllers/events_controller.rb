class EventsController < ApplicationController
  #before_action :signed_in_user, only: [:index]

  def index
    #grab all live events
    @user = current_user
    if @user != nil && @user.admin?
      puts "Event sync"
      Event.sync('live')
    end
    @viewable_events = Event.all.reorder("date_time DESC").paginate(page: params[:page], :per_page => 3)
  end
  
  def filter
    #@data = Event.where(params[:by_attribute] => params[:value])
    #@poop = Hash[@data.map { |u| [u.id, u] }]
    #puts @poop
    #@data = "fuck you"
    #respond_to do |format|
    #  format.json { render :json => @poop}
    #end
  end
  
  

  private

    def event_params
      #params.require(:event).permit(:title, :event_type, :date_time, :about, :location, photos_attributes: [:id, :imageable_id, :image])
      params.require(:event).permit(:title, :event_type, :date_time, :about, :location, :url, :max_attendees, :status, :image, :attendees)
      #params.require(:title, :about, :event_type, :location, :url, :max_attendees, :date_time, :status, :event_id).permit(:image, :attendees)
    end
end