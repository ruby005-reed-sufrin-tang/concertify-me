class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @user = User.find(params[:id])
    @poop = @user.all_playlists
  end
  
  def new
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

end
