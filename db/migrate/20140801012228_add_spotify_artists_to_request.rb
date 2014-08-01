class AddSpotifyArtistsToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :spotify_artists, :string
  end
end
