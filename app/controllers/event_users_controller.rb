class EventUsersController < ApplicationController
  def create
    params[:event_user].each do |key, value|
      next if key == "user_id" 
      event_id = key.split("_").last.to_i
      if value=="0" && (event_to_delete = EventUser.find_by(event_id: event_id, user_id: current_user.id))
        binding.pry
        EventUser.destroy(event_to_delete.id)
      elsif value=="1"
        EventUser.find_or_create_by(event_id: event_id, user_id: current_user.id)
      end
    end
    redirect_to user_events_path(current_user)
  end

  def delete
    event_to_delete = EventUser.find_by(event_id: params[:event_user][:event_id], user_id: current_user.id)
    EventUser.destroy(event_to_delete.id)
    redirect_to user_events_path(current_user)
  end
end