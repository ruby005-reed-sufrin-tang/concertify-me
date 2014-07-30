class ArtistRequest < ActiveRecord::Base
  belongs_to :artist
  belongs_to :request
end
