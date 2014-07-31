class EmailsController < ApplicationController
  def create
    # Tell the UserMailer to send a welcome email after save
    # This doesn't actually happen. It's just an example
   # raise params.inspect
    @user = current_user
    @event = Event.find(params[:email][:event_id])
   # @user.email = params[:user][:email]
   # @user.save
    UserMailer.example_email(@user, @event).deliver
    #render json:{}
    redirect_to user_path(current_user)
  end

  def new
  end
end