class Artist < ActiveRecord::Base
  has_many :artist_requests
  has_many :requests, through: :artist_requests

  has_many :artist_events
  has_many :events, through: :artist_events

  has_many :artist_users
  has_many :usrs, through: :artist_users
end
