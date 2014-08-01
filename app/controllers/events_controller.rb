class EventsController < ApplicationController
  def show
  end

  def index
    @events = Event.joins(:event_users).where(:event_users => {:user_id => current_user.id}).order(:datetime)
  end

  def top
      address = Geocoder.address(remote_ip).split(', ')
      if address[2] == "United States"
        city = address[0]
        state = address[1][0..1]
        @location = "#{city}, #{state}"
      else
        @location = ""
      end
    @top_events = Event.top_events
  end
end