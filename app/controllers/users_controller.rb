class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
   @spotify_artists = current_user.all_playlists
   
    
  end
  
  def new
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

end
