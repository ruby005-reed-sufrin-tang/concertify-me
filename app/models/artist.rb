class Artist < ActiveRecord::Base
  has_many :artist_requests
  has_many :artists, through: :artist_requests
end
