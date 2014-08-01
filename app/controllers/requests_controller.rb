class RequestsController < ApplicationController



  SEARCH = [:artist,:city,:state]

  def index 
  end

  def new
    @user = current_user
    @request = Request.new
    @spotify_artists = current_user.spotify_artists.to_a.collect {|artist| artist.name}
    if @spotify_artists.empty?
      @spotify_artists = current_user.all_playlists
      @spotify_artists.each  do |x|
        current_user.spotify_artists.create(name: x) 
      end
    end
    @user = current_user
  end

  def create
 
    @checkboxes = params["request"].collect {|x,y| x if y=="1"}.compact
    @request = Request.create(search_params)
    search_artist = Artist.find_or_create_by(name: search_params[:artist])
    search_artist.save

    
    
    @request.artist_requests.create(artist_id: search_artist.id)
    @request.api_call

    @request.create_events(search_artist)

    @spotify_events = @request.spotify_events_api_call(@checkboxes)

    @request.create_events

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
