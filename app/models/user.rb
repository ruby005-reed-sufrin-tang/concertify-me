require 'open-uri'

class User < ActiveRecord::Base

 def self.create_from_omniauth(auth_hash)
  self.create(provider: auth_hash[:provider],
              uid: auth_hash[:uid],
              name: auth_hash[:info][:name],
              email: auth_hash[:info][:name]
              )
  end

  def self.find_by_provider_and_uid(provider, uid)
    where(provider: provider, uid: uid).first
  end

  def all_playlists
    user =  self.uid 
    link = "https://api.spotify.com/v1/users/#{user}/playlists"
    json = JSON.load(open(link){|io| data= io.read})
  end
end
