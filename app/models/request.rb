
class Request < ActiveRecord::Base
  has_many :artist_requests
  has_many :artists, through: :artist_requests
  has_many :event_requests
  has_many :events, through: :event_requests
  has_many :spotify_events

  validates :city,:state,:artist, presence: true
  
  def api_call
    artist_name = self.artist.gsub(" ","%20")
    city = self.city.gsub(" ","+")
    state = self.state.gsub(" ","+")
    link = "http://api.bandsintown.com/artists/#{artist_name}/events/recommended?format=json&app_id=concertify&api_version=2.0&location=#{city},#{state}&callback=showEvents"    
    @results = JSON.load(open(link){|io| data= io.read}[11..-3])
  end



  def spotify_events_api_call(checkboxes)
    city = self.city.gsub(" ","+")
    state = self.state.gsub(" ","+")
    checkboxes.each do |artist|
      a = artist.dup
      a.gsub!(" ","%20")
      a.gsub!("'","%27")
     artist_name = a
    link = "http://api.bandsintown.com/artists/#{artist_name}/events/recommended?format=json&app_id=concertify&api_version=2.0&location=#{city},#{state}&callback=showEvents"    
    @results = JSON.load(open(link){|io| data= io.read}[11..-3])
  end
  end

  # def spotify_artists_call(checkboxes)
  #   city = self.city.gsub(" ","+")
  #   state = self.state.gsub(" ","+")
  #   link = "http://api.bandsintown.com/events/search?artists[]="
  #   link += checkboxes.join("&artists[]=").gsub(" ","%20")
  #   link.gsub!("'","%27")
  #   link += "&format=json&app_id=concertify&location="
  #   link += city +","
  #   link += state
  #   @results = JSON.load(open(link))
  # end


  def create_events(search_artist = Artist.new)

    @results.each do |result|
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
        event.artist_events.create(:artist_id => artist.id)
      end
      if !!search_artist.name
        exact_match = ((result["artists"].select{|result_artist| result_artist["name"].downcase == search_artist.name.downcase }).count >= 1)
    else
        exact_match = false
      end
      event_requests.create(event_id: event.id, 
                            searched_artist_id: search_artist.id,
                            exact_match: exact_match)
    end
  end

end

