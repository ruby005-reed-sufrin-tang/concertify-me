
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
    json = JSON.load(open(link){|io| data= io.read}[11..-3])
  end

  def all_playlists
    user =  self.uid 
    link = "https://api.spotify.com/v1/users/#{user}/playlists"
    token = self.token
    playlists = JSON.load(open("https://api.spotify.com/v1/users/#{user}/playlists/","Authorization" => "Bearer #{token}"))["items"].collect {|x| x["tracks"]["href"]}
    artists = playlists.collect do |x|
      JSON.load(open("#{x}","Authorization" => "Bearer #{token}"))["items"].collect { |x| x["track"]["artists"][0]["name"]}.uniq
    end.flatten
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

