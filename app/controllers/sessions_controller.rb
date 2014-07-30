class SessionsController < ApplicationController

  def create 
     
    auth = request.env["omniauth.auth"]     
    user = User.find_by_provider_and_uid(auth[:provider], auth[:uid]) || User.create_from_omniauth(auth)     
    session[:user_id] = user.id     
    redirect_to root_url, :notice => "Signed in!"

    request.env["omniauth.auth"]["credentials"]["token"]

     request.env["omniauth.auth"]["credentials"]["refresh_token"]

  end
 
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
