class Event < ActiveRecord::Base
  has_many :users
  has_one :photo, as: :imageable
  validates :title, presence: true, length: { maximum: 50 }
  validates :url, presence: true
  validates :date_time, presence: true
  validates :location, presence: true
  validates :status, presence: true
  validates :event_id, presence: true
  default_scope -> { order('created_at DESC') }
  
  def Event.sync(status_type)
    # give correct oauth token
    Eventbrite.token= ENV['EVENTBRITE_OAUTH']
    
    # get json object/array called events
    #events = Eventbrite::User.owned_events({ user_id: '97799945735', status: 'live', order_by: 'start_desc'})   
    data = Eventbrite::User.owned_events({ user_id: '100902716149', status: status_type.to_s, order_by: 'start_desc'})   
    
    # figure the number of elements in json array
    num_events = data.events.length
    
    # iterate through array
    for i in 0..(num_events-1)
      event = data.events[i]
      
      # find out how many tickets sold total
      tickets = 0
      for j in 0..(event.ticket_classes.length-1)
        tickets += Integer(event.ticket_classes[j].quantity_sold)
      end
      
      event_address = event.venue.address.address_1
      if (event.venue.address.address_2 != nil)
        event_address += ' '
        event_address += event.venue.address.address_2
      end
      event_address += ', '
      event_address += event.venue.address.city
      event_address += ', '
      event_address += event.venue.address.region
      if (event.venue.address.postal_code != nil)
        event_address += ' '
        event_address += event.venue.address.postal_code
      end
      
      # fill out all values in param
      param = {
        :title => event.name.text,
        :about => event.description.text, 
        :event_type => event.category.name, 
        :location => event_address, 
        :url => event.url, 
        :max_attendees => event.capacity, 
        :date_time => event.start.local, 
        :status => event.status, 
        :event_id => event.id,
        :image => event.logo.url,
        :attendees => tickets.to_s,
      }
      # end of for loop for json array
      eventToUpdate = Event.where(event_id: param[:event_id]).load
      if eventToUpdate.count==0
        eventToSave = Event.new(param)
        eventToSave.save
      else 
        eventToUpdate[0].update_attributes(param)
      end
    end
  end
  
end
