class CreateSpotifyEvents < ActiveRecord::Migration
  def change
    create_table :spotify_events do |t|
      t.string :title
      t.datetime :datetime
      t.string :formatted_datetime
      t.string :location
      t.string :ticket_url
      t.string :facebook_rsvp_url

      t.timestamps
    end
  end
end
