class AddThumbUrlToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :thumb_url, :string
  end
end
