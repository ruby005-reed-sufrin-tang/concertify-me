class EmailsController < ApplicationController
  def create
  #tells usr_mailer.rb which email to send
   # raise params.inspect
   #binding.pry
    @user = current_user
    @event = Event.find(params[:email][:event_id])

   
    UserMailer.example_email(@user, @event).deliver
    render json:{}
    #redirect_to user_path(current_user)
  end

  def new
  end
end