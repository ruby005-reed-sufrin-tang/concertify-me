
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
end

