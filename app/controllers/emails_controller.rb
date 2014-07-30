class EmailsController < ApplicationController
  def create
    # Tell the UserMailer to send a welcome email after save
    @user = User.find(params[:email][:user_id])
    @user.email = params[:email][:email_address]
    @user.save
    UserMailer.example_email(@user).deliver
    redirect_to user_path(current_user)
  end
end