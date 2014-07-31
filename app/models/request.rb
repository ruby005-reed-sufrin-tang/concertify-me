
class Request < ActiveRecord::Base
  has_many :artist_requests
  has_many :artists, through: :artist_requests
  has_many :event_requests
  has_many :events, through: :event_requests
  
  def api_call
    artist_name = self.artist.gsub(" ","%20")
    city = self.city.gsub(" ","+")
    state = self.state.gsub(" ","+")
    link = "http://api.bandsintown.com/artists/#{artist_name}/events/recommended?format=json&app_id=concertify&api_version=2.0&location=#{city},#{state}&callback=showEvents"    
    @results = JSON.load(open(link){|io| data= io.read}[11..-3])
  end

  def create_events(search_artist)
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

      exact_match = ((result["artists"].select{|result_artist| result_artist["name"] == search_artist.name}).count >= 1)
      
      event_requests.create(event_id: event.id, 
                            searched_artist_id: search_artist.id,
                            exact_match: exact_match)
    end
  end

  def all_playlists
    user =  self.uid 
    link = "https://api.spotify.com/v1/users/#{user}/playlists"
    token = self.token
    playlists = JSON.load(open("https://api.spotify.com/v1/users/#{user}/playlists/","Authorization" => "Bearer #{token}"))["items"].collect {|x| x["tracks"]["href"]}
    artists = playlists.collect do |x|
      JSON.load(open("#{x}","Authorization" => "Bearer #{token}"))["items"].collect { |x| x["track"]["artists"][0]["name"]}.uniq
    end.flatten.uniq
  end

  # def spotify_artists

  #     current_user.all_playlists.collect do |artist_name|
  #     city = self.city.gsub(" ","+")
  #     state = self.state.gsub(" ","+")
  #     link = "http://api.bandsintown.com/artists/#{artist_name}/events/recommended?format=json&app_id=somuchpoop&api_version=2.0&location=#{city},#{state}&callback=showEvents"
  #     encoded_url = URI.encode(link)
  #     thing = URI.parse(encoded_url)
  #     json = JSON.load(open(thing){|io| data= io.read}[11..-3])
  #   end 

  # end

end

