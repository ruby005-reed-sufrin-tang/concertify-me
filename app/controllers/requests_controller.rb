class RequestsController < ApplicationController

  SEARCH = [:artist,:city,:state]

  def index 
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.create(search_params)
    artist = Artist.find_or_create_by(name: search_params[:artist])
    artist.save
    
    @request.artist_requests.create(artist_id: artist.id)
    results = @request.api_call

    results.each do |result|
      event = Event.find_or_create_by(title: result["title"],
                                      datetime: result["datetime"],
                                      formatted_datetime: result["formatted_datetime"],
                                      location: result["formatted_location"])

      exact_match = ((result["artists"].select{|result_artist| result_artist["name"] == artist.name}).count >= 1)
      
      @request.event_requests.create(event_id: event.id, 
                                     searched_artist_id: artist.id,
                                     exact_match: exact_match)
    end
    redirect_to request_url(@request)
  end

  def show
    @request = Request.find(params[:id])
    @artist_events = Event.joins(:event_requests).where(:event_requests => {:request_id => @request.id, :exact_match => true})
    @related_events = Event.joins(:event_requests).where(:event_requests => {:request_id => @request.id, :exact_match => false})
  end 

  private

  def search_params
    params.require(:request).permit(SEARCH)
  end
end
