class RequestsController < ApplicationController

  SEARCH = [:artist,:city,:state]

  def index 
  end

  def new
    @request = Request.new  
  end

  def create

    @request = Request.create(search_params)
    search_artist = Artist.find_or_create_by(name: search_params[:artist])
    search_artist.save
    
    @request.artist_requests.create(artist_id: search_artist.id)
    @request.api_call
    @request.create_events(search_artist)

    redirect_to request_url(@request)
  end

  def show
    #@poop = current_user.all_playlists
    @request = Request.find(params[:id])
    @artist_events = Event.joins(:event_requests).where(:event_requests => {:request_id => @request.id, :exact_match => true})
    @related_events = Event.joins(:event_requests).where(:event_requests => {:request_id => @request.id, :exact_match => false})

    # @work = @poop.collect do |artist_name|
    # city = @request.city.gsub(" ","+")
    # state = @request.state.gsub(" ","+")
    #   link = "http://api.bandsintown.com/artists/#{artist_name}/events/recommended?format=json&app_id=somuchpoop&api_version=2.0&location=#{city},#{state}&callback=showEvents"
    #   encoded_url = URI.encode(link)
    #   thing = URI.parse(encoded_url)
    #   json = JSON.load(open(thing){|io| data= io.read}[11..-3])
    # end 
  end 

  private

  def search_params
    params.require(:request).permit(SEARCH)
  end
end
