class AddSearchedArtistIdToEventRequests < ActiveRecord::Migration
  def change
    add_column :event_requests, :searched_artist_id, :integer
  end
end
