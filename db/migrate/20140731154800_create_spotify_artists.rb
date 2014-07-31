class CreateSpotifyArtists < ActiveRecord::Migration
  def change
    create_table :spotify_artists do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
