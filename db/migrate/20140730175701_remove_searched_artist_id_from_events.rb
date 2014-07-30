class RemoveSearchedArtistIdFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :searched_artist_id, :integer
  end
end
