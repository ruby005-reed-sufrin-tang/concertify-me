class ArtistUsersController < ApplicationController
  def show
  end

  def delete
    artist = ArtistUser.find_by(user_id: current_user.id, id: params[:id])
    ArtistUser.destroy(params[:id]) if artist
    redirect_to user_artists_path(current_user)
  end
end