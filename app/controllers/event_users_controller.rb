class EventUsersController < ApplicationController
  def create
    @user = User.find(params[:event_user][:user_id])
    params[:event_user].each do |key, value|
      next if key == :user_id
      event_id = value.split("_").last.to_i
      EventUser.create(event_id: event_id, user_id: @user.id)
    end
    redirect_to user_path(@user)
  end
end