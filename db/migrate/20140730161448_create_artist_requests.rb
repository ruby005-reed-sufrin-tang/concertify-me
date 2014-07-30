class CreateArtistRequests < ActiveRecord::Migration
  def change
    create_table :artist_requests do |t|
      t.integer :request_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
