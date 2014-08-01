class AddSpotifyEventToEvents < ActiveRecord::Migration
  def change
    add_column :events, :spotify_event, :boolean,:default => false
  end
end
