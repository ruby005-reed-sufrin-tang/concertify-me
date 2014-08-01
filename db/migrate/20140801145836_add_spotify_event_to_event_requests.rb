class AddSpotifyEventToEventRequests < ActiveRecord::Migration
  def change
    add_column :event_requests, :spotify_event, :boolean, :default => false

  end
end
