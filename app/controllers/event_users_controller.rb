class EventUsersController < ApplicationController
  def create
    @user = User.find(params[:event_user][:user_id])
    params[:event_user].each do |key, value|
      next if key == "user_id" 
      
      event_id = key.split("_").last.to_i
      if value=="0" && (event_to_delete = EventUser.find_by(event_id: event_id, user_id: @user.id))
        binding.pry
        EventUser.destroy(event_to_delete.id)
      elsif value=="1"
        EventUser.find_or_create_by(event_id: event_id, user_id: @user.id)
      end
    end
    redirect_to user_path(@user)
  end
end