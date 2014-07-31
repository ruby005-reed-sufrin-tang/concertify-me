class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  
   @events = Event.joins(:event_users).where(:event_users => {:user_id => current_user.id}).order(:datetime)

  end
  
  def new
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

end
