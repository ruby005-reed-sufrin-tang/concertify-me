class AddUserIdToSpotifyEvents < ActiveRecord::Migration
  def change
    add_column :spotify_events, :user_id, :integer
  end
end
