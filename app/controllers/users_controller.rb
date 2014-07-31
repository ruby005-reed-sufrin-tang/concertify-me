class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show  
   @user = current_user
  end
  
  def new
  end

  def update
    if params[:id].to_i == current_user.id
      @user = current_user
      @user.email = params[:user][:email]
      @user.save
    end
    flash[:notice] = "Email address updated"
    redirect_to user_path(@user)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

end
