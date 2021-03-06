class RequestsController < ApplicationController



  SEARCH = [:artist,:city,:state]

  def index 
  end

  def new
    @request = Request.new
    @spotify_artists = current_user.spotify_artists.to_a.collect {|artist| artist.name}
    @artist = params[:artist]
  end

  def create
    if search_params[:city].empty? || search_params[:state].empty?
      address = Geocoder.address(remote_ip).split(', ')
      if address[2] == "United States"
        params[:request][:city] = address[0]
        params[:request][:state] = address[1][0..1]
      end
    end
    @request = Request.new(search_params)
    @request.spotify_artists = params["request"].collect {|x,y| x if y=="1"}.compact.join(",")
    if @request.artist.empty? && @request.spotify_artists.empty?
      flash[:error] = "Must include at least one artist in search!"
      redirect_to new_request_path and return
    end
    @request.save
    begin
      if !@request.artist.empty?
        search_artist = Artist.find_or_create_by(name: search_params[:artist])
        @request.artist_requests.create(artist_id: search_artist.id)
        current_user.artist_users.find_or_create_by(artist_id: search_artist.id)
        @request.api_call
        @request.create_events(search_artist)
      end

      @request.spotify_artists.split(",").each do |artist|
        search_artist = Artist.find_or_create_by(name: artist)
        ar = @request.artist_requests.build(artist_id: search_artist.id)
        ar.save
      end

      if !@request.spotify_artists.empty?
        @spotify_events = @request.spotify_events_api_call()
        @request.create_events
      end

      @request.spotify_artists.split(",").each do |spot|
        @request.event_requests.each do |x|
          if x.event.title.include?(spot)
              x.update(spotify_event: true, exact_match: true)
              x.save 
          end
        end
      end

      redirect_to request_url(@request)
    rescue Exception => e
 
      flash[:notice] = "Search failed! Please verify your parameters."
      redirect_to new_request_path and return
    end


  end

  def show

    @request = Request.find(params[:id])
    @spotify_events = Event.joins(:event_requests).where(:event_requests => {:request_id => @request.id, :exact_match => true, :spotify_event => true})
    @artist_events = Event.joins(:event_requests).where(:event_requests => {:request_id => @request.id, :exact_match => true, :spotify_event => false})
    @related_events = Event.joins(:event_requests).where(:event_requests => {:request_id => @request.id, :exact_match => false})
  end 

  private

  def search_params
    params.require(:request).permit(SEARCH)
  end
end
