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
                                      formatted_datetime: result["formatted_datetime"],
                                      location: result["formatted_location"])
      if !event.datetime || !event.facebook_rsvp_url || !event.ticket_url
        event.datetime = result["datetime"]
        event.ticket_url = result["ticket_url"]
        event.facebook_rsvp_url = result["facebook_rsvp_url"]
        event.save
      end

      result["artists"].each do |result_artist|
        artist = Artist.find_or_create_by(name: result_artist["name"])
        artist.thumb_url = result_artist["thumb_url"]
        artist.save
        binding.pry
        event.event_artist
      end

      exact_match = ((result["artists"].select{|result_artist| result_artist["name"] == artist.name}).count >= 1)
      
      @request.event_requests.create(event_id: event.id, 
                                     searched_artist_id: artist.id,
                                     exact_match: exact_match)
    end
    redirect_to request_url(@request)
  end

  def show
    @poop = current_user.all_playlists
    @request = Request.find(params[:id])
    @artist_events = Event.joins(:event_requests).where(:event_requests => {:request_id => @request.id, :exact_match => true})
    @related_events = Event.joins(:event_requests).where(:event_requests => {:request_id => @request.id, :exact_match => false})

    @work = @poop.collect do |artist_name|
    city = @request.city.gsub(" ","+")
    state = @request.state.gsub(" ","+")
      link = "http://api.bandsintown.com/artists/#{artist_name}/events/recommended?format=json&app_id=somuchpoop&api_version=2.0&location=#{city},#{state}&callback=showEvents"
      encoded_url = URI.encode(link)
      thing = URI.parse(encoded_url)
      json = JSON.load(open(thing){|io| data= io.read}[11..-3])
    end 
  end 

  private

  def search_params
    params.require(:request).permit(SEARCH)
  end
end
