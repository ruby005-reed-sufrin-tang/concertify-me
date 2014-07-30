class RequestsController < ApplicationController

  SEARCH = [:artist,:city,:state]

  def index 
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.create(search_params)
    artist = @request.artists.new(name: search_params[:artist])

    artist.save
    @request.artist_requests.create(artist_id: artist.id)
    results = @request.api_call

    results.each do |result|
      event = @request.events.new(title: result["title"],
                                    datetime: result["datetime"],
                                    formatted_datetime: result["formatted_datetime"],
                                    location: result["formatted_location"],
                                    searched_artist_id: artist.id)

      
      event.save
      @request.event_requests.create(event_id: event.id)
    end
    binding.pry
    redirect_to request_url(@request)
  end

  def show
    @request = Request.find(params[:id])
  end 

  private

  def search_params
    params.require(:request).permit(SEARCH)
  end
end
