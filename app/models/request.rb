
require 'open-uri'
class Request < ActiveRecord::Base



  def api_call

    artist_name = self.artist.gsub(" ","%20")

    city = self.city.gsub(" ","+")

    state = self.state.gsub(" ","+")

    link = "http://api.bandsintown.com/artists/#{artist_name}/events/recommended?format=json&app_id=somuchpoop&api_version=2.0&location=#{city},#{state}&callback=showEvents"

    json = JSON.load(open(link){|io| data= io.read}[11..-3])

  end
end
