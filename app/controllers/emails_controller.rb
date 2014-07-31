class EmailsController < ApplicationController
  def create
    @user = current_user
    @event = Event.find(params[:email][:event_id])

    UserMailer.example_email(@user, @event).deliver
    render json:{}
  end

  def new
  end
end