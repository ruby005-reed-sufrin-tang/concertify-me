class EventsController < ApplicationController
  def show
  end

  def index
    @events = Event.joins(:event_users).where(:event_users => {:user_id => current_user.id}).order(:datetime)
  end
end