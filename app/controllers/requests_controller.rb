class RequestsController < ApplicationController



  SEARCH = [:artist,:city,:state]

  def index 
  end

  def new
    @request = Request.new
    @spotify_artists = current_user.spotify_artists.to_a.collect {|artist| artist.name}
    if @spotify_artists.empty?
      @spotify_artists = current_user.all_playlists
      @spotify_artists.each  do |x|
        current_user.spotify_artists.create(name: x) 
      end
    end
  end

  def create
    if search_params[:city].empty? || search_params[:state].empty?
      flash[:error] = "A city and state are required!"
      redirect_to new_request_path and return
    else
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

        redirect_to request_url(@request)
      rescue Exception => e
        binding.pry
        flash[:notice] = "Search failed! Please verify your parameters."
        redirect_to new_request_path and return
      end
    end
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
