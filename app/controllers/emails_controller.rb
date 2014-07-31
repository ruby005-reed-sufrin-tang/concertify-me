class EmailsController < ApplicationController
  def create
    # Tell the UserMailer to send a welcome email after save
    # This doesn't actually happen. It's just an example
    @user = User.find(params[:user][:id])
    @user.email = params[:user][:email]
    @user.save
    UserMailer.example_email(@user).deliver
    render json:{}
  end
end