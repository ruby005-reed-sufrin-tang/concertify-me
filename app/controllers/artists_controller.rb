class ArtistsController < ApplicationController
  # def show
  # end

  def index
    @artists = Artist.joins(:artist_users).where(:artist_users => {:user_id => current_user.id}).order(:created_at => :asc).distinct.limit(5)
    @spotify_artists = current_user.spotify_artists
  end
end