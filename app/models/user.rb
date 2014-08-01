class User < ActiveRecord::Base
  has_many :event_users
  has_many :events, through: :event_users
  has_many :spotify_artists
  has_many :spotify_events
  has_many :artist_users
  has_many :artists, through: :artist_users



 def self.create_from_omniauth(auth_hash)
  self.create(provider: auth_hash[:provider],
              uid: auth_hash[:uid],
              name: auth_hash[:info][:name],
              email: auth_hash[:info][:email],
              token: auth_hash[:credentials][:token]
              )
  end

  def self.find_by_provider_and_uid(provider, uid)
    where(provider: provider, uid: uid).first
  end

  def all_playlists
    user =  self.uid 
    link = "https://api.spotify.com/v1/users/#{user}/playlists"
    token = self.token
    playlists = JSON.load(open("https://api.spotify.com/v1/users/#{user}/playlists/","Authorization" => "Bearer #{token}"))["items"].collect {|x| x["tracks"]["href"]}
    artists = playlists.collect do |x|
      JSON.load(open("#{x}","Authorization" => "Bearer #{token}"))["items"].collect { |x| x["track"]["artists"][0]["name"]}
    end.flatten
    artist_count = artists.inject(Hash.new(0)) {|hash,artist| hash[artist] += 1;hash}
    artist_count_sort = artist_count.sort_by { |k, v| v }.reverse
    artist_count_sort.collect { |x| 
      x[0]
      }.reject(&:empty?)[0..9]
  end

end
