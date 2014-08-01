require 'base64'
class SpotifyArtistsController < ApplicationController

  def show  
    
  end

  def update
    current_user.spotify_artists.destroy_all
    
    enc = Base64.encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}").gsub("\n","")
    command = "curl -H 'Authorization: Basic #{enc}' -d grant_type=refresh_token -d refresh_token=#{current_user.refresh_token} https://accounts.spotify.com/api/token" 
    
    json = `#{command}`
    results = JSON.parse(json)
    if results["access_token"]
      current_user.token = results["access_token"]
    end
    @spotify_artists = current_user.all_playlists
    @spotify_artists.each  do |x|
      current_user.spotify_artists.create(name: x) 
    end
    
    flash[:notice] = "Artists updated!"
    redirect_to user_artists_path(current_user)
  end

end